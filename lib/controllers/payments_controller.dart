import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/payments_model/payments_model.dart';
import 'package:bizreh_paints_store/services/payments_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';

class PaymentsController extends GetxController {
  final PaymentsServices _paymentsServices = PaymentsServices();

  final Rxn<PaymentsModel> paymentsData = Rxn<PaymentsModel>();
  final RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadPayments();
  }

  Future<void> loadPayments() async {
    isLoading.value = true;
    try {
      final result = await _paymentsServices.getPayments();
      paymentsData.value = result;
    } on AppException catch (e) {
      log("payments controller AppException get payments : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("payments controller catch get payments : ${e.toString()}");
      showMassage("حدث خطأ حاول مرة اخرى", false);
    } finally {
      isLoading.value = false;
    }
  }
}
