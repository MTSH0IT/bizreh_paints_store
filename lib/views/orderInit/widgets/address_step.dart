import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/savedAddress/widgets/address_card.dart';

class AddressStep extends StatelessWidget {
  final OrderController orderController;
  final AddressController addressController;
  final VoidCallback onAddressSelected;

  const AddressStep({
    super.key,
    required this.orderController,
    required this.addressController,
    required this.onAddressSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (addressController.isLoading.value) {
        return const BuildProgressIndicator();
      }
      final List<AddressModel> items = addressController.addresses;
      if (items.isEmpty) {
        return const Center(
          child: Text(
            'لا توجد عناوين محفوظة، قم بإضافة عنوان أولاً من صفحة العناوين',
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final address = items[index];
          final isSelected =
              address.id == orderController.selectedAddress.value?.id;
          return GestureDetector(
            onTap: () {
              orderController.selectedAddress.value = address;
              onAddressSelected();
            },
            child: Opacity(
              opacity: isSelected ? 1.0 : 0.8,
              child: AddressCard(isSelcted: isSelected, address: address),
            ),
          );
        },
      );
    });
  }
}
