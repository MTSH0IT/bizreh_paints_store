import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/discont_model/discont_model.dart';
import 'package:bizreh_paints_store/models/point_rule_model.dart';
import 'package:bizreh_paints_store/services/rewards_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/services/product_services.dart';
import 'package:bizreh_paints_store/views/productDetails/product_details_view.dart';
import 'package:easy_localization/easy_localization.dart';

class RewardsController extends GetxController {
  final RewardsServices _services;
  final ProductServices _productServices;

  RewardsController({
    required RewardsServices rewardsServices,
    required ProductServices productServices,
  }) : _services = rewardsServices,
       _productServices = productServices;

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
      showMassage(tr('common.error_try_again'), false);
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
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoadingPointsRules.value = false;
    }
  }

  Future<void> navigateToProductDetails(int productId) async {
    Get.dialog(const BuildProgressIndicator(), barrierDismissible: false);
    try {
      final productModel = await _productServices.getProductById(id: productId);
      Get.back(); // Close loading dialog
      Get.to(() => ProductDetailsView(product: productModel));
    } catch (e) {
      Get.back(); // Close loading dialog
      log("rewards controller catch navigate to product : ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    }
  }
}
