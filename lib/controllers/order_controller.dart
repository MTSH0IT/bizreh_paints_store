import 'package:bizreh_paints_store/controllers/cart_controllers.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';
import 'package:bizreh_paints_store/services/order_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderController extends GetxController {
  final OrderServices _orderServices;
  final CartController cartController;

  OrderController({
    required OrderServices orderServices,
    required CartController cartController,
  }) : _orderServices = orderServices,
       this.cartController = cartController;

  var phoneNumber = ''.obs;
  var selectedAddress = Rxn<AddressModel>();
  var paymentMethod = 'cash'.obs; // cash, card, etc.
  var isSubmitting = false.obs;

  // order history state
  var orders = <OrderModel>[].obs;
  var isHistoryLoading = false.obs;
  var historyError = ''.obs;

  // order details state
  var selectedOrderDetails = Rxn<OrderModel>();
  var isOrderDetailsLoading = false.obs;
  var orderDetailsError = ''.obs;

  List<String> get paymentMethods => ['cash', 'visa'];

  Future<void> loadOrderDetails(int id) async {
    try {
      isOrderDetailsLoading.value = true;
      orderDetailsError.value = '';
      selectedOrderDetails.value = await _orderServices.getOrderDetails(id);
    } catch (e) {
      orderDetailsError.value = e.toString();
    } finally {
      isOrderDetailsLoading.value = false;
    }
  }

  void setPhone(String value) {
    phoneNumber.value = value.trim();
  }

  void setPaymentMethod(String method) {
    paymentMethod.value = method;
  }

  Future<void> loadOrderHistory() async {
    try {
      isHistoryLoading.value = true;
      historyError.value = '';
      final response = await _orderServices.getOrderHistory();
      orders.assignAll(response.data ?? []);
    } catch (e) {
      historyError.value = e.toString();
    } finally {
      isHistoryLoading.value = false;
    }
  }

  Future<void> cancelOrder(int id, String reason) async {
    try {
      isSubmitting.value = true;
      await _orderServices.cancelOrder(id, reason);

      await loadOrderHistory();

      showMassage(tr('common.canceled_successfully'), true);
    } catch (e) {
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> reorder(int id, Map<String, dynamic> body) async {
    try {
      isSubmitting.value = true;
      await _orderServices.reorder(id, body);
      await loadOrderHistory();

      showMassage(tr('common.sent_successfully'), true);
    } catch (e) {
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> complaint(int id, String message) async {
    try {
      isSubmitting.value = true;
      await _orderServices.complaint(id, message);
      await loadOrderHistory();

      showMassage(tr('common.sent_successfully'), true);
    } catch (e) {
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> submitOrder() async {
    final orderId = cartController.cart.value?.id;
    final addressId = selectedAddress.value?.id;

    if (orderId == null || orderId <= 0) {
      showMassage('تعذر ارسال الطلب: رقم الطلب غير متوفر', false);
      return;
    }
    if (addressId == null || addressId <= 0) {
      showMassage(tr('common.please_select_address'), false);
      return;
    }

    try {
      isSubmitting.value = true;
      await _orderServices.createOrder(orderId: orderId, addressId: addressId);
      cartController.cart.value = null;
      Get.back();
      showMassage(tr('common.sent_successfully'), true);
    } catch (e) {
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isSubmitting.value = false;
    }
  }
}
