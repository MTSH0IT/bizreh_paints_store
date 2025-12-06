import 'package:bizreh_paints_store/services/address_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/models/cities_model.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';

class AddressController extends GetxController {
  // Services
  final AddressServices _addressServices = AddressServices();

  // Reactive state
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;

  // Data
  final RxList<AddressModel> addresses = <AddressModel>[].obs;
  final RxList<AddressModel> addressesActive = <AddressModel>[].obs;
  final RxList<CitiesModel> cities = <CitiesModel>[].obs;
  final Rxn<AddressModel> defaultAddress = Rxn<AddressModel>();

  // Form controllers
  final TextEditingController nicknameCtrl = TextEditingController();
  final TextEditingController addressLineCtrl = TextEditingController();
  final TextEditingController noteCtrl = TextEditingController();

  final RxnInt selectedCityId = RxnInt();

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
      addresses.assignAll(res);
      isLoading.value = false;
    } catch (e) {
      log("address controller loadAddresses error: ${e.toString()}");
      showMassage("فشل في جلب العناوين", false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCities() async {
    isLoading.value = true;
    try {
      final res = await _addressServices.getCities();
      cities.assignAll(res);
      isLoading.value = false;
    } catch (e) {
      log("address controller loadCities error: ${e.toString()}");
      showMassage("فشل في جلب المدن", false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadDefaultAddress() async {
    isLoading.value = true;
    try {
      final res = await _addressServices.getDefaultAddress();
      defaultAddress.value = res;
      isLoading.value = false;
    } catch (e) {
      log("address controller loadDefaultAddress error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

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
      showMassage("تمت إضافة العنوان بنجاح", true);
      isSubmitting.value = false;
    } catch (e) {
      log("address controller createAddress error: ${e.toString()}");
      showMassage("حدث خطأ أثناء إضافة العنوان", false);
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
        cityId: cityId!,
        addressLine: addressLine,
        note: note,
        latitude: lat!,
        longitude: lag!,
      );
      await loadAddresses();
      showMassage("تم تعديل العنوان بنجاح", true);
      isSubmitting.value = false;
    } catch (e) {
      log("address controller updateAddress error: ${e.toString()}");
      showMassage("حدث خطأ أثناء تعديل العنوان", false);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> deleteAddress(int id) async {
    isSubmitting.value = true;
    try {
      await _addressServices.deleteAddress(id: id);
      // تحديث محلي لقائمة العناوين بدون إعادة تحميل من السيرفر
      AddressModel? removed;
      for (final a in addresses) {
        if (a.id == id) {
          removed = a;
          break;
        }
      }

      addresses.removeWhere((e) => e.id == id);
      addresses.refresh();

      // إذا كان العنوان المحذوف هو الافتراضي، أفرغ القيمة الافتراضية
      if (removed != null && defaultAddress.value?.id == removed.id) {
        defaultAddress.value = null;
      }

      showMassage("تم حذف العنوان", true);
      isSubmitting.value = false;
    } catch (e) {
      log("address controller deleteAddress error: ${e.toString()}");
      showMassage("تعذر حذف العنوان", false);
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> setDefault(int id) async {
    isSubmitting.value = true;
    try {
      await _addressServices.setDefaultAddress(id: id);
      // تحديث محلي للعنوان الافتراضي من القائمة الحالية بدون طلب جديد
      AddressModel? newDefault;
      for (final a in addresses) {
        if (a.id == id) {
          newDefault = a;
          break;
        }
      }

      if (newDefault != null) {
        defaultAddress.value = newDefault;
        addresses.refresh();
      }

      showMassage("تم تعيين العنوان الافتراضي", true);
      isSubmitting.value = false;
    } catch (e) {
      log("address controller setDefault error: ${e.toString()}");
      showMassage("تعذر تعيين العنوان الافتراضي", false);
    } finally {
      isSubmitting.value = false;
    }
  }

  // Helpers
  bool _validateFields() {
    if (cityId == null) {
      showMassage("يرجى اختيار المدينة", false);

      return false;
    }
    if (addressLine.isEmpty) {
      showMassage("يرجى إدخال العنوان", false);
      return false;
    }
    if (lat == null || lag == null) {
      showMassage("يرجى تحديد الموقع", false);
      return false;
    }
    if (nickname.isEmpty) {
      showMassage("يرجى إدخال الاسم", false);
      return false;
    }
    return true;
  }

  void clearForm() {
    selectedCityId.value = null;
    nicknameCtrl.clear();
    addressLineCtrl.clear();
    noteCtrl.clear();
    latitude.value = null;
    longitude.value = null;
    getLocationAndFill();
  }

  void fillFormFrom(AddressModel model) {
    selectedCityId.value = model.cityId;
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
