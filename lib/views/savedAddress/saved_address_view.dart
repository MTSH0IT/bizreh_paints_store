import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              Get.to(() => ManageAddressView());
            },
            icon: const Icon(Icons.add, color: primaryColor),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: demoAddressesModel.length,
          itemBuilder: (context, index) {
            final address = demoAddressesModel[index];
            return AddressCard(
              address: address,
              onEdit: () => Get.to(() => ManageAddressView(address: address)),
              onDelete: () => _deleteAddress(address),
            );
          },
        ),
      ),
    );
  }

  void _deleteAddress(AddressModel address) {
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
              setState(() {
                demoAddressesModel.removeWhere((a) => a.id == address.id);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
