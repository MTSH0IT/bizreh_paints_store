import 'package:bizreh_paints_store/controllers/cart_controllers.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/models/order_history_model.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';
import 'package:bizreh_paints_store/services/order_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final CartController cartController = Get.find<CartController>();
  final OrderServices _orderServices = OrderServices();

  var phoneNumber = ''.obs;
  var selectedAddress = Rxn<AddressModel>();
  var paymentMethod = 'cash'.obs; // cash, card, etc.
  var isSubmitting = false.obs;

  // order history state
  var orders = <OrderHistoryModel>[].obs;
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

      final index = orders.indexWhere((o) => o.id == id);
      if (index != -1) {
        orders[index].status = 'canceled';
        orders.refresh();
      }

      showMassage('تم الغاء الطلب بنجاح', true);
    } catch (e) {
      showMassage('فشل الغاء الطلب، حاول مرة اخرى', false);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> reorder(int id, Map<String, dynamic> body) async {
    try {
      isSubmitting.value = true;
      await _orderServices.reorder(id, body);
      await loadOrderHistory();

      showMassage('تم إعادة الطلب بنجاح', true);
    } catch (e) {
      showMassage('فشل إعادة الطلب، حاول مرة اخرى', false);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> complaint(int id, String message) async {
    try {
      isSubmitting.value = true;
      await _orderServices.complaint(id, message);
      await loadOrderHistory();

      showMassage('تمت الشكوى بنجاح', true);
    } catch (e) {
      showMassage('فشلت الشكوى، حاول مرة اخرى', false);
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
      showMassage('اختر عنوان التوصيل', false);
      return;
    }

    try {
      isSubmitting.value = true;
      await _orderServices.createOrder(orderId: orderId, addressId: addressId);
      cartController.cart.value = null;
      Get.back();
      showMassage('تم ارسال الطلب بنجاح', true);
    } catch (e) {
      showMassage('فشل ارسال الطلب، حاول مرة اخرى', false);
    } finally {
      isSubmitting.value = false;
    }
  }
}
