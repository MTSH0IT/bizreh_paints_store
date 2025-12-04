import 'dart:developer';

import 'package:bizreh_paints_store/controllers/my_cart_controller.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/models/order_history_model.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';
import 'package:bizreh_paints_store/services/order_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:bizreh_paints_store/views/mainView/main_view.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final MyCartController cartController = Get.find<MyCartController>();
  //final AddressServices _addressServices = AddressServices();
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
    // if (cartController.isEmpty()) {
    //   showMassage('السلة فارغة', false);
    //   return;
    // }
    // if (phoneNumber.value.isEmpty) {
    //   showMassage('ادخل رقم الهاتف', false);
    //   return;
    // }
    // if (selectedAddress.value == null) {
    //   showMassage('اختر عنوان التوصيل', false);
    //   return;
    // }

    final items = cartController.cartItems
        .map(
          (item) => {
            'option_packaging_id': item.packagingId,
            'quantity_per_unit': item.quantity,
          },
        )
        .toList();
    log(selectedAddress.value!.id.toString());

    final body = {
      'items': items,
      'delivery_address': selectedAddress.value!.id,
      'phone_number': phoneNumber.value,
      'payment_method': paymentMethod.value,
    };

    try {
      isSubmitting.value = true;
      //await _orderServices.createOrder(body: body);
      //showMassage('تم ارسال الطلب بنجاح', true);
      cartController.clearCart();
      //Get.offAll(() => MainView());
      Get.back();
    } catch (e) {
      showMassage('فشل ارسال الطلب، حاول مرة اخرى', false);
    } finally {
      isSubmitting.value = false;
    }
  }
}
