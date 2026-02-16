import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'map_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class MapCard extends StatelessWidget {
  const MapCard({super.key, required this.center});

  final LatLng? center;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8, top: 12),
          child: Text(
            'address_manage.get_current_location'.tr(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 180,
            color: Colors.grey.shade200,
            child: Stack(
              children: [
                if (center != null)
                  MapWidget(
                    center: center,
                    isInteractive: false,
                    height: 180,
                    zoom: 13,
                  )
                else
                  Center(
                    child: Text(
                      'address_manage.updating_location'.tr(),
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Colors.black.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Icon(Icons.touch_app, color: Colors.white, size: 30),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
