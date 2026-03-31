import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/points_history_model/points_history_model.dart';
import 'package:bizreh_paints_store/models/user_points_model.dart';
import 'package:bizreh_paints_store/services/points_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';

class PointsController extends GetxController {
  final PointsServices _pointsServices = PointsServices();

  final Rxn<UserPointsModel> points = Rxn<UserPointsModel>();
  final RxList<PointsHistoryModel> history = <PointsHistoryModel>[].obs;

  final RxBool isLoadingPoints = false.obs;
  final RxBool isLoadingHistory = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    await Future.wait([loadPoints(), loadHistory()]);
  }

  Future<void> loadPoints() async {
    isLoadingPoints.value = true;
    try {
      final result = await _pointsServices.getUserPoints();
      points.value = result;
    } on AppException catch (e) {
      log("points controller AppException get points : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("points controller catch get points : ${e.toString()}");
      showMassage("حدث خطأ حاول مرة اخرى", false);
    } finally {
      isLoadingPoints.value = false;
    }
  }

  Future<void> loadHistory() async {
    isLoadingHistory.value = true;
    try {
      final result = await _pointsServices.getPointsHistory();
      history.assignAll(result);
    } on AppException catch (e) {
      log("points controller AppException get history : ${e.message}");
      showMassage(e.message, false);
    } catch (e) {
      log("points controller catch get history : ${e.toString()}");
      showMassage("حدث خطأ حاول مرة اخرى", false);
    } finally {
      isLoadingHistory.value = false;
    }
  }
}
