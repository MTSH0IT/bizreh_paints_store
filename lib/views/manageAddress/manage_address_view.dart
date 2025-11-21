import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'package:bizreh_paints_store/models/cities_model.dart';
import 'widgets/labeled_text_field.dart';
import 'widgets/city_dropdown.dart';
import 'widgets/map_card.dart';
import 'widgets/full_screen_map.dart';

class ManageAddressView extends StatelessWidget {
  final AddressModel? address;
  final AddressController addressController = Get.find<AddressController>();
  ManageAddressView({super.key, this.address});

  Future<void> _ensureCitiesLoaded() async {
    if (addressController.cities.isEmpty) {
      await addressController.loadCities();
    }
  }

  Future<void> _lodedata() async {
    if (address != null) {
      addressController.fillFormFrom(address!);
    }
  }

  LatLng? _currentCenter() {
    final lat = addressController.lat;
    final lng = addressController.lag;
    if (lat == null || lng == null) return null;
    return LatLng(lat.toDouble(), lng.toDouble());
  }

  Future<void> _saveAddress() async {
    if (address != null) {
      await addressController.updateAddress(id: address!.id!);
    } else {
      await addressController.createAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure data readiness without causing rebuild loops
    _ensureCitiesLoaded();
    _lodedata();
    return Scaffold(
      appBar: AppBar(
        title: Text(address != null ? 'Edit Address' : 'Add New Address'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Obx(() {
          final citiesOptions = addressController.cities
              .map((e) => e.title ?? '')
              .toList();
          final selectedCityName = () {
            final id = addressController.selectedCityId.value;
            if (id == null) return null;
            final c = addressController.cities.firstWhere(
              (e) => e.id == id,
              orElse: () => CitiesModel(),
            );
            return c.title ?? "";
          }();

          final center = _currentCenter();

          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                children: [
                  LabeledTextField(
                    label: 'Nickname',
                    controller: addressController.nicknameCtrl,
                  ),

                  CityDropdown(
                    label: 'City',
                    value: selectedCityName,
                    options: citiesOptions.isEmpty ? const [''] : citiesOptions,
                    onChanged: (v) {
                      final matched = addressController.cities.firstWhere(
                        (c) => c.title == v,
                        orElse: () => CitiesModel(),
                      );
                      if (matched.id != null) {
                        addressController.selectedCityId.value = matched.id;
                      }
                    },
                  ),
                  LabeledTextField(
                    label: 'Address Line',
                    controller: addressController.addressLineCtrl,
                  ),
                  LabeledTextField(
                    label: 'Notes',
                    controller: addressController.noteCtrl,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      if (center == null) return;
                      final selectedLocation = await Get.to<LatLng>(
                        () => FullScreenMap(initialCenter: center),
                      );
                      if (selectedLocation != null) {
                        addressController.latitude.value =
                            selectedLocation.latitude;

                        addressController.longitude.value =
                            selectedLocation.longitude;
                      }
                    },
                    child: MapCard(center: center),
                  ),
                  const SizedBox(height: 20),
                  MainButton(
                    onPressed: addressController.isSubmitting.value
                        ? null
                        : _saveAddress,
                    title: addressController.isSubmitting.value
                        ? 'Please wait...'
                        : (address != null ? 'Update Address' : 'Save Address'),
                  ),
                ],
              ),
              if (addressController.isSubmitting.value)
                Positioned.fill(
                  child: Container(
                    color: Colors.black38,
                    child: const BuildProgressIndicator(),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
