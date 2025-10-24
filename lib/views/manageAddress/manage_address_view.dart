import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'widgets/labeled_text_field.dart';
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
  final nicknameCtrl = TextEditingController();
  // final firstNameCtrl = TextEditingController();
  // final lastNameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final notesCtrl = TextEditingController();

  String? city;
  LatLng? center;

  @override
  void initState() {
    super.initState();
    if (widget.address == null) {
      _getLocation();
    }
    _loadAddressData();
  }

  void _loadAddressData() {
    if (widget.address != null) {
      nicknameCtrl.text = widget.address!.nickname;
      addressCtrl.text = widget.address!.address;
      notesCtrl.text = widget.address!.notes;
      city = widget.address!.city;

      // تحويل الإحداثيات من String إلى LatLng
      if (widget.address!.latitude.isNotEmpty &&
          widget.address!.longitude.isNotEmpty) {
        center = LatLng(
          double.parse(widget.address!.latitude),
          double.parse(widget.address!.longitude),
        );
      }
    }
  }

  @override
  void dispose() {
    nicknameCtrl.dispose();
    // firstNameCtrl.dispose();
    // lastNameCtrl.dispose();
    addressCtrl.dispose();
    notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return;
    }
    final pos = await Geolocator.getCurrentPosition();
    setState(() => center = LatLng(pos.latitude, pos.longitude));
  }

  void _saveAddress() {
    if (nicknameCtrl.text.isEmpty || addressCtrl.text.isEmpty || city == null) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final address = AddressModel(
      id:
          widget.address?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      nickname: nicknameCtrl.text,
      city: city!,
      address: addressCtrl.text,
      notes: notesCtrl.text,
      latitude: center?.latitude.toString() ?? '',
      longitude: center?.longitude.toString() ?? '',
    );

    if (widget.address != null) {
      // تحديث العنوان الموجود
      final index = demoAddressesModel.indexWhere(
        (a) => a.id == widget.address!.id,
      );
      if (index != -1) {
        demoAddressesModel[index] = address;
      }
      Get.snackbar(
        'Success',
        'Address updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      // إضافة عنوان جديد
      demoAddressesModel.add(address);
      Get.snackbar(
        'Success',
        'Address added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.address != null ? 'Edit Address' : 'Add New Address',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            LabeledTextField(label: 'Nickname', controller: nicknameCtrl),
            // Row(
            //   children: [
            //     Expanded(
            //       child: LabeledTextField(
            //         label: 'First Name',
            //         controller: firstNameCtrl,
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: LabeledTextField(
            //         label: 'Last Name',
            //         controller: lastNameCtrl,
            //       ),
            //     ),
            //   ],
            // ),
            CityDropdown(
              label: 'City',
              value: city,
              options: const ['damascus', 'homs', 'hama', 'aleppo', 'latakia'],
              onChanged: (v) => setState(() => city = v),
            ),
            LabeledTextField(label: 'Address Line', controller: addressCtrl),
            LabeledTextField(
              label: 'Notes',
              controller: notesCtrl,
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
                  setState(() {
                    center = selectedLocation;
                    log(center.toString());
                  });
                }
              },
              child: MapCard(center: center),
            ),
            const SizedBox(height: 20),
            MainButton(
              onPressed: () {
                _saveAddress();
              },
              title: widget.address != null ? 'Update Address' : 'Save Address',
            ),
          ],
        ),
      ),
    );
  }
}
