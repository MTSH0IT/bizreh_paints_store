import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class MapWidget extends StatefulWidget {
  final LatLng? center;
  final void Function(LatLng)? onLocationSelected;
  final bool isInteractive;
  final double height;
  final double zoom;

  const MapWidget({
    super.key,
    this.center,
    this.onLocationSelected,
    this.isInteractive = true,
    this.height = 200,
    this.zoom = 15,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  MapController mapController = MapController();
  LatLng? currentSelectedLocation;

  @override
  void initState() {
    super.initState();
    currentSelectedLocation = widget.center;
  }

  @override
  void didUpdateWidget(MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.center != oldWidget.center) {
      setState(() {
        currentSelectedLocation = widget.center;
      });
      // تحديث مركز الخريطة عند تغيير الموقع المختار
      if (currentSelectedLocation != null) {
        mapController.move(currentSelectedLocation!, widget.zoom);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: widget.center!,
          initialZoom: widget.zoom,
          onTap: widget.isInteractive && widget.onLocationSelected != null
              ? (tapPosition, point) {
                  widget.onLocationSelected!(point);
                }
              : null,
          interactionOptions: widget.isInteractive
              ? const InteractionOptions()
              : const InteractionOptions(flags: InteractiveFlag.none),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          if (widget.center != null)
            MarkerLayer(
              markers: [
                Marker(
                  rotate: true,
                  alignment: Alignment.topCenter,
                  point: widget.center!,
                  child: Icon(
                    Icons.location_on,
                    color: primaryColor,
                    size: widget.isInteractive ? 45 : 35,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
