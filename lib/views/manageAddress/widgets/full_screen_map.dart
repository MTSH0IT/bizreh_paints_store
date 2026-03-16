import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'map_widget.dart';

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({super.key, this.initialCenter});
  final LatLng? initialCenter;
  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialCenter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        titleKey: 'address_manage.select_location',
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: selectedLocation != null
          ? FloatingActionButton.extended(
              onPressed: () {
                Get.back(result: selectedLocation);
              },
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.check),
              label: Text(tr('address_manage.confirm')),
            )
          : null,
      body: Stack(
        children: [
          MapWidget(
            center: selectedLocation,
            onLocationSelected: (location) {
              setState(() {
                selectedLocation = location;
              });
            },
            isInteractive: true,
            height: MediaQuery.of(context).size.height,
            zoom: 15,
          ),
          // ØªØ¹Ù„ÙŠÙ…Ø§Øª Ù„Ù„Ù…Ø³ØªØ®Ø¯Ù…
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                tr('address_manage.tap_to_select_location'),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
