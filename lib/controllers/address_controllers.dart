import 'package:bizreh_paints_store/services/address_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/models/cities_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:easy_localization/easy_localization.dart';

class AddressController extends GetxController {
  // Services
  final AddressServices _addressServices;

  AddressController({required AddressServices addressServices})
    : _addressServices = addressServices;

  // Reactive state
  final RxBool isLoading = false.obs;
  final RxBool isLoadingCities = false.obs;
  final RxBool isSubmitting = false.obs;

  // Data
  final RxList<AddressModel> addresses = <AddressModel>[].obs;
  final RxList<AddressModel> addressesActive = <AddressModel>[].obs;
  final RxList<CitiesModel> cities = <CitiesModel>[].obs;
  // final Rxn<AddressModel> defaultAddress = Rxn<AddressModel>();

  // Form controllers
  final TextEditingController nicknameCtrl = TextEditingController();
  final TextEditingController addressLineCtrl = TextEditingController();
  final TextEditingController noteCtrl = TextEditingController();

  final RxnInt selectedCityId = RxnInt();
  final RxnString selectedCityName = RxnString();

  final RxnDouble latitude = RxnDouble();
  final RxnDouble longitude = RxnDouble();

  // Getters
  String get nickname => nicknameCtrl.text.trim();
  String get addressLine => addressLineCtrl.text.trim();
  String get note => noteCtrl.text.trim();

  int? get cityId => selectedCityId.value;
  double? get lat => latitude.value;
  double? get lag => longitude.value;

  @override
  void onInit() {
    //loadDefaultAddress();
    loadAddresses();
    //loadCities();

    super.onInit();
  }

  @override
  void onClose() {
    nicknameCtrl.dispose();
    addressLineCtrl.dispose();
    noteCtrl.dispose();
    super.onClose();
  }

  // Loaders
  Future<void> loadAddresses() async {
    isLoading.value = true;
    try {
      final res = await _addressServices.getAddresses();
      // final filtered = res
      //     .where(
      //       (a) =>
      //           (a.nickname?.trim().isNotEmpty ?? false) &&
      //           (a.addressLine?.trim().isNotEmpty ?? false) &&
      //           (a.cityId != null),
      //     )
      //     .toList();
      addresses.assignAll(res);
    } catch (e) {
      log("address controller loadAddresses error: ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCities() async {
    isLoadingCities.value = true;
    try {
      final res = await _addressServices.getCities();
      cities.assignAll(res);
    } catch (e) {
      log("address controller loadCities error: ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isLoadingCities.value = false;
    }
  }

  // Future<void> loadDefaultAddress() async {
  //   isLoading.value = true;
  //   try {
  //     final res = await _addressServices.getDefaultAddress();
  //     defaultAddress.value = res;
  //     isLoading.value = false;
  //   } catch (e) {
  //     log("address controller loadDefaultAddress error: ${e.toString()}");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // CRUD
  Future<void> createAddress() async {
    if (!_validateFields()) return;
    isSubmitting.value = true;
    try {
      await _addressServices.createAddress(
        nickName: nickname,
        cityId: cityId!,
        addressLine: addressLine,
        note: note,
        latitude: lat!,
        longitude: lag!,
      );
      await loadAddresses();
      showMassage(tr('common.added_successfully'), true);
      Get.back();
      isSubmitting.value = false;
    } catch (e) {
      log("address controller createAddress error: ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> updateAddress({required int id}) async {
    if (!_validateFields()) return;
    isSubmitting.value = true;
    try {
      await _addressServices.updateAddress(
        id: id,
        nickName: nickname,
        cityId: cityId!,
        addressLine: addressLine,
        note: note,
        latitude: lat!,
        longitude: lag!,
      );
      await loadAddresses();
      showMassage(tr('common.updated_successfully'), true);
      isSubmitting.value = false;
    } catch (e) {
      log("address controller updateAddress error: ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> deleteAddress(int id) async {
    isSubmitting.value = true;
    try {
      await _addressServices.deleteAddress(id: id);

      addresses.removeWhere((e) => e.id == id);
      addresses.refresh();

      // إذا كان العنوان المحذوف هو الافتراضي، أفرغ القيمة الافتراضية
      // if (removed != null && defaultAddress.value?.id == removed.id) {
      //   defaultAddress.value = null;
      // }

      showMassage(tr('common.deleted_successfully'), true);
      isSubmitting.value = false;
    } catch (e) {
      log("address controller deleteAddress error: ${e.toString()}");
      showMassage(tr('common.error_try_again'), false);
    } finally {
      isSubmitting.value = false;
    }
  }

  // Future<void> setDefault(int id) async {
  //   isSubmitting.value = true;
  //   try {
  //     await _addressServices.setDefaultAddress(id: id);
  //     // تحديث محلي للعنوان الافتراضي من القائمة الحالية بدون طلب جديد
  //     AddressModel? newDefault;
  //     for (final a in addresses) {
  //       if (a.id == id) {
  //         newDefault = a;
  //         break;
  //       }
  //     }
  //     if (newDefault != null) {
  //       defaultAddress.value = newDefault;
  //       addresses.refresh();
  //     }
  //     showMassage(tr('common.updated_successfully'), true);
  //     isSubmitting.value = false;
  //   } catch (e) {
  //     log("address controller setDefault error: ${e.toString()}");
  //     showMassage(tr('common.error_try_again'), false);
  //   } finally {
  //     isSubmitting.value = false;
  //   }
  // }

  // Helpers
  bool _validateFields() {
    if (cityId == null) {
      showMassage(tr('common.please_select_city'), false);

      return false;
    }
    if (addressLine.isEmpty) {
      showMassage(tr('common.please_enter_address'), false);
      return false;
    }
    if (lat == null || lag == null) {
      showMassage(tr('common.please_select_location'), false);
      return false;
    }
    if (nickname.isEmpty) {
      showMassage(tr('common.please_enter_name'), false);
      return false;
    }
    return true;
  }

  void setSelectedCity(int? cityId, String? cityName) {
    selectedCityId.value = cityId;
    selectedCityName.value = cityName;
  }

  // New helper methods for UI
  List<String> getLocalizedCities(BuildContext context) {
    return cities
        .map((e) => context.localizedValue(en: e.title, ar: e.arTitle))
        .toList();
  }

  String? getSelectedCityLocalizedName(BuildContext context) {
    final city = cities.firstWhereOrNull((c) => c.id == selectedCityId.value);
    if (city == null) return null;
    return context.localizedValue(en: city.title, ar: city.arTitle);
  }

  void updateCityByLocalizedName(String? name, BuildContext context) {
    if (name == null) return;
    final matched = cities.firstWhereOrNull(
      (c) => context.localizedValue(en: c.title, ar: c.arTitle) == name,
    );
    if (matched != null) {
      setSelectedCity(matched.id, matched.title);
    }
  }

  void clearForm() {
    selectedCityId.value = null;
    selectedCityName.value = null;
    nicknameCtrl.clear();
    addressLineCtrl.clear();
    noteCtrl.clear();
    latitude.value = null;
    longitude.value = null;
    getLocationAndFill();
  }

  Future<void> initForm(AddressModel? model) async {
    if (cities.isEmpty) {
      await loadCities();
    }
    if (model == null) {
      await getLocationAndFill();
    } else {
      fillFormFrom(model);
    }
  }

  void fillFormFrom(AddressModel model) {
    selectedCityId.value = model.cityId;
    // Find and set city name
    final city = cities.firstWhereOrNull((c) => c.id == model.cityId);
    selectedCityName.value = city?.title;
    nicknameCtrl.text = model.nickname ?? '';
    addressLineCtrl.text = model.addressLine ?? '';
    noteCtrl.text = model.note ?? '';
    latitude.value = model.latitude;
    longitude.value = model.longitude;
  }

  Future<void> getLocationAndFill() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return;
    }
    final pos = await Geolocator.getCurrentPosition();
    latitude.value = pos.latitude;
    longitude.value = pos.longitude;
  }
}
