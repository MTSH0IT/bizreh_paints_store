import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/views/manageAddress/manage_address_view.dart';
import 'widgets/address_card.dart';

class SavedAddressView extends StatefulWidget {
  const SavedAddressView({super.key});

  @override
  State<SavedAddressView> createState() => _SavedAddressViewState();
}

class _SavedAddressViewState extends State<SavedAddressView> {
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: const Text(
          'Saved Addresses',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              addressController.clearForm();
              Get.to(() => ManageAddressView());
            },
            icon: const Icon(Icons.add, color: primaryColor),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final List<AddressModel> items = addressController.addresses;
          if (addressController.isLoading.value) {
            return const BuildProgressIndicator();
          }
          if (items.isEmpty) {
            return const Center(child: Text('No addresses found'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final address = items[index];

              return GestureDetector(
                onTap: () {
                  addressController.setDefault(address.id!);
                },
                child: AddressCard(
                  isDefaultAddress:
                      address.id == addressController.defaultAddress.value?.id!,
                  address: address,
                  onEdit: () {
                    Get.to(() => ManageAddressView(address: address));
                  },
                  onDelete: () => _confirmDelete(address.id, address),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void _confirmDelete(int? id, AddressModel address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Address'),
        content: Text('Are you sure you want to delete ${address.nickname}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (id != null) {
                addressController.deleteAddress(id);
              }
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
