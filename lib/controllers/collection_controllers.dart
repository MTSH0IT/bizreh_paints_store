import 'dart:developer';

import 'package:bizreh_paints_store/helper/exceptions/app_exception.dart';
import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/services/collection_services.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:get/get.dart';

class CollectionControllers extends GetxController {
  final CollectionServices _collectionServices = CollectionServices();

  final RxList<CollectionModel> collections = <CollectionModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    getCollections();
    super.onInit();
  }

  Future<void> getCollections() async {
    try {
      isLoading.value = true;
      final fetched = await _collectionServices.getCollections();
      collections.assignAll(fetched);
    } on AppException catch (e) {
      showMassage(e.message, false);
      log('AppException in getCollections: ${e.message}');
    } catch (e) {
      showMassage('Failed to load collections', false);
      log('Error in getCollections: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
