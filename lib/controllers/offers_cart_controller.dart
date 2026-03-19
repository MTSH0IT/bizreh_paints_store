import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/offers_cart_model.dart';
import 'package:bizreh_paints_store/services/offers_cart_service.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';

class OffersCartController extends GetxController {
  final OffersCartService _service = OffersCartService();

  final RxList<OffersCartModel> offers = <OffersCartModel>[].obs;
  final RxBool isLoadingOffers = false.obs;
  final RxString offersError = ''.obs;

  final RxInt purchasingOfferId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadOffers();
  }

  Future<void> loadOffers() async {
    isLoadingOffers.value = true;
    offersError.value = '';
    try {
      final result = await _service.getAvailableOffers();
      offers.assignAll(result);
    } on AppException catch (e) {
      log('offers cart controller AppException load offers : ${e.message}');
      offersError.value = e.message;
      showMassage(e.message, false);
    } catch (e) {
      log('offers cart controller catch load offers : ${e.toString()}');
      offersError.value = e.toString();
      showMassage('حدث خطأ حاول مرة اخرى', false);
    } finally {
      isLoadingOffers.value = false;
    }
  }

  Future<void> purchaseOffer({
    required int offerId,
    required int quantity,
    required int addressId,
  }) async {
    purchasingOfferId.value = offerId;
    try {
      await _service.purchaseOffer(
        offerId: offerId,
        quantity: quantity,
        addressId: addressId,
      );
      showMassage('تم طلب العرض بنجاح', true);
      await loadOffers();
    } on AppException catch (e) {
      log('offers cart controller AppException purchase offer : ${e.message}');
      showMassage(e.message, false);
    } catch (e) {
      log('offers cart controller catch purchase offer : ${e.toString()}');
      showMassage('حدث خطأ حاول مرة اخرى', false);
    } finally {
      purchasingOfferId.value = 0;
    }
  }
}
