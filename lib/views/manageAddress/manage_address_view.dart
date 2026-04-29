import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/labeled_text_field.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'widgets/city_dropdown.dart';
import 'widgets/map_card.dart';
import 'widgets/full_screen_map.dart';

class ManageAddressView extends StatefulWidget {
  final AddressModel? address;
  const ManageAddressView({super.key, this.address});

  @override
  State<ManageAddressView> createState() => _ManageAddressViewState();
}

class _ManageAddressViewState extends State<ManageAddressView> {
  final AddressController addressController = Get.find<AddressController>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => addressController.initForm(widget.address));
  }

  LatLng? _currentCenter() {
    final lat = addressController.lat;
    final lng = addressController.lag;
    if (lat == null || lng == null) return null;
    return LatLng(lat.toDouble(), lng.toDouble());
  }

  Future<void> _handleSave() async {
    if (widget.address != null) {
      await addressController.updateAddress(id: widget.address!.id!);
    } else {
      await addressController.createAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: Text(
          widget.address != null ? tr('address.edit') : tr('address.add_new'),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final citiesOptions = addressController.getLocalizedCities(context);
          final selectedCityName = addressController
              .getSelectedCityLocalizedName(context);
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
                    hint: tr('address.nickname_hint'),
                    label: tr('address.nickname'),
                    controller: addressController.nicknameCtrl,
                  ),
                  CityDropdown(
                    label: tr('address.city'),
                    value: selectedCityName,
                    options: citiesOptions.isEmpty ? const [''] : citiesOptions,
                    onChanged: (v) =>
                        addressController.updateCityByLocalizedName(v, context),
                  ),
                  LabeledTextField(
                    hint: tr('address.address_line_hint'),
                    label: tr('address.address_line'),
                    controller: addressController.addressLineCtrl,
                  ),
                  LabeledTextField(
                    hint: tr('address.notes_hint'),
                    label: tr('address.notes'),
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
                        : _handleSave,
                    title: addressController.isSubmitting.value
                        ? tr('address.please_wait')
                        : (widget.address != null
                              ? tr('address.update')
                              : tr('address.save')),
                  ),
                ],
              ),
              if (addressController.isSubmitting.value)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Colors.black38,
                    child: BuildProgressIndicator(),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
