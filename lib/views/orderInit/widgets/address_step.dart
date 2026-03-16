import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/manageAddress/manage_address_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr('order_init.no_saved_addresses'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            MainButton(
              title: tr('order_init.add_address'),
              onPressed: () {
                Get.to(() => ManageAddressView());
              },
            ),
          ],
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
