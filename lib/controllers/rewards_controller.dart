import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/discont_model/discont_model.dart';
import 'package:bizreh_paints_store/models/point_rule_model.dart';
import 'package:bizreh_paints_store/services/rewards_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';

class RewardsController extends GetxController {
  final RewardsServices _services;

  RewardsController({required RewardsServices rewardsServices})
    : _services = rewardsServices;

  final RxList<DiscontModel> discountOffers = <DiscontModel>[].obs;
  final RxList<PointRuleModel> pointsRules = <PointRuleModel>[].obs;

  final RxBool isLoadingDiscounts = false.obs;
  final RxBool isLoadingPointsRules = false.obs;

  final RxString discountsError = ''.obs;
  final RxString pointsRulesError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    await Future.wait([loadDiscountOffers(), loadPointsRules()]);
  }

  Future<void> loadDiscountOffers() async {
    isLoadingDiscounts.value = true;
    discountsError.value = '';
    try {
      final result = await _services.getDiscountOffers();
      discountOffers.assignAll(result);
    } on AppException catch (e) {
      log("rewards controller AppException discounts : ${e.message}");
      discountsError.value = e.message;
      showMassage(e.message, false);
    } catch (e) {
      log("rewards controller catch discounts : ${e.toString()}");
      discountsError.value = e.toString();
      showMassage("حدث خطأ حاول مرة اخرى", false);
    } finally {
      isLoadingDiscounts.value = false;
    }
  }

  Future<void> loadPointsRules() async {
    isLoadingPointsRules.value = true;
    pointsRulesError.value = '';
    try {
      final result = await _services.getPointsRules();
      pointsRules.assignAll(result);
    } on AppException catch (e) {
      log("rewards controller AppException points rules : ${e.message}");
      pointsRulesError.value = e.message;
      showMassage(e.message, false);
    } catch (e) {
      log("rewards controller catch points rules : ${e.toString()}");
      pointsRulesError.value = e.toString();
      showMassage("حدث خطأ حاول مرة اخرى", false);
    } finally {
      isLoadingPointsRules.value = false;
    }
  }
}
