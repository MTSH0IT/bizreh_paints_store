import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/views/manageAddress/manage_address_view.dart';
import 'package:bizreh_paints_store/views/savedAddress/widgets/address_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class OffersCartAddressPickerView extends StatelessWidget {
  const OffersCartAddressPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCtrl = Get.find<AddressController>();

    return Scaffold(
      appBar: CommonAppBar(title: Text(tr('offers_cart.select_address'))),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Obx(() {
              if (addressCtrl.isLoading.value) {
                return const BuildProgressIndicator();
              }

              final items = addressCtrl.addresses;
              if (items.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        tr('order_init.no_saved_addresses'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Get.to(() => ManageAddressView()),
                      child: Text(tr('order_init.add_address')),
                    ),
                  ],
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final address = items[index];
                  return GestureDetector(
                    onTap: () => Get.back<AddressModel>(result: address),
                    child: Opacity(
                      opacity: 0.95,
                      child: AddressCard(address: address),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
