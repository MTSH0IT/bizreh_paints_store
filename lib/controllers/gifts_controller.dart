import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/available_gifts_model.dart';
import 'package:bizreh_paints_store/models/gifts_model.dart';
import 'package:bizreh_paints_store/models/user_gifts_model.dart';
import 'package:bizreh_paints_store/services/gifts_service.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class GiftsController extends GetxController {
  final GiftsService _giftsService;

  GiftsController({required GiftsService giftsServices})
    : _giftsService = giftsServices;

  final RxList<GiftsModel> gifts = <GiftsModel>[].obs;
  final RxList<UserGiftsModel> myGifts = <UserGiftsModel>[].obs;
  final RxList<AvailableGiftsModel> availableGifts =
      <AvailableGiftsModel>[].obs;
  final RxInt availablePoints = 0.obs;

  final RxBool isLoadingGifts = false.obs;
  final RxBool isLoadingMyGifts = false.obs;
  final RxBool isLoadingAvailable = false.obs;
  final RxInt redeemingGiftId = 0.obs;

  final Rxn<GiftsModel> selectedGift = Rxn<GiftsModel>();
  final RxBool isLoadingSelectedGift = false.obs;
  final RxString selectedGiftError = ''.obs;

  final RxInt tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    await Future.wait([loadAvailable(), loadMyGifts(), loadGifts()]);
  }

  Future<void> loadGifts() async {
    isLoadingGifts.value = true;
    try {
      final result = await _giftsService.getAllGifts();
      gifts.assignAll(result);
    } on AppException catch (e) {
      log("gifts controller AppException get gifts : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("gifts controller catch get gifts : ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoadingGifts.value = false;
    }
  }

  Future<void> loadMyGifts() async {
    isLoadingMyGifts.value = true;
    try {
      final result = await _giftsService.getMyGifts();
      myGifts.assignAll(result);
    } on AppException catch (e) {
      log("gifts controller AppException get my gifts : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("gifts controller catch get my gifts : ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoadingMyGifts.value = false;
    }
  }

  Future<void> loadAvailable() async {
    isLoadingAvailable.value = true;
    try {
      final result = await _giftsService.getAvailableGifts();
      availablePoints.value = result.availablePoints ?? 0;
      availableGifts.assignAll(result.gifts);
    } on AppException catch (e) {
      log("gifts controller AppException get available : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("gifts controller catch get available : ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoadingAvailable.value = false;
    }
  }

  Future<void> redeemGift(int giftId) async {
    redeemingGiftId.value = giftId;
    try {
      await _giftsService.redeemGift(giftId: giftId);
      showMassage(tr('common.sent_successfully'), true);
      await Future.wait([loadAvailable(), loadMyGifts()]);
    } on AppException catch (e) {
      log("gifts controller AppException redeem : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("gifts controller catch redeem : ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      redeemingGiftId.value = 0;
    }
  }

  void setTab(int index) {
    tabIndex.value = index;
  }

  Future<void> loadGiftById(int giftId) async {
    isLoadingSelectedGift.value = true;
    selectedGiftError.value = '';
    try {
      final gift = await _giftsService.getGiftById(giftId: giftId);
      selectedGift.value = gift;
    } on AppException catch (e) {
      log("gifts controller AppException get by id : ${e.message}");
      selectedGiftError.value = e.message;
      showMassage(e.message, false);
    } catch (e) {
      log("gifts controller catch get by id : ${e.toString()}");
      selectedGiftError.value = e.toString();
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoadingSelectedGift.value = false;
    }
  }
}
