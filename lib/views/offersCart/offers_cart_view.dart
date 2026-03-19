import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'package:bizreh_paints_store/controllers/offers_cart_controller.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/models/offers_cart_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/views/manageAddress/manage_address_view.dart';
import 'package:bizreh_paints_store/views/savedAddress/widgets/address_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class OffersCartView extends StatelessWidget {
  const OffersCartView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<OffersCartController>();

    return Scaffold(
      appBar: CommonAppBar(
        title: Text(tr('offers_cart.title')),
        actions: [
          IconButton(
            onPressed: () => ctrl.loadOffers(),
            icon: const Icon(Icons.refresh),
            tooltip: tr('offers_cart.refresh'),
          ),
        ],
      ),
      body: Obx(() {
        final isLoading = ctrl.isLoadingOffers.value;
        final err = ctrl.offersError.value.trim();
        final offers = ctrl.offers;

        if (isLoading && offers.isEmpty) {
          return const BuildProgressIndicator();
        }

        if (offers.isEmpty) {
          return Center(child: Text(tr('offers_cart.no_offers')));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: offers.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final offer = offers[i];
            return _OfferCard(
              offer: offer,
              isPurchasing: ctrl.purchasingOfferId.value == offer.id,
              onPurchase: () => _purchase(context, offer),
            );
          },
        );
      }),
    );
  }

  Future<void> _purchase(BuildContext context, OffersCartModel offer) async {
    if (offer.id == null) return;

    final address = await Get.to<AddressModel?>(
      () => const _AddressPickerView(),
    );
    if (address?.id == null) return;

    final qty = await _askQuantity(offer);
    if (qty == null) return;

    final ctrl = Get.find<OffersCartController>();
    await ctrl.purchaseOffer(
      offerId: offer.id!,
      quantity: qty,
      addressId: address!.id!,
    );
  }

  Future<int?> _askQuantity(OffersCartModel offer) async {
    final maxQty = offer.quantity ?? 1;
    final ctrl = TextEditingController();

    final result = await Get.dialog<int>(
      AlertDialog(
        title: Text(tr('offers_cart.enter_quantity')),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: tr('offers_cart.quantity_hint'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back<int>(),
            child: Text(tr('common.cancel')),
          ),
          TextButton(
            onPressed: () {
              final parsed = int.tryParse(ctrl.text.trim());
              final qty = (parsed == null || parsed <= 0) ? null : parsed;
              if (qty == null) {
                return;
              }
              if (qty > maxQty) {
                Get.back<int>(result: maxQty);
                return;
              }
              Get.back<int>(result: qty);
            },
            child: Text(tr('offers_cart.confirm_purchase')),
          ),
        ],
      ),
      barrierDismissible: true,
    );

    ctrl.dispose();
    return result;
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.offer,
    required this.isPurchasing,
    required this.onPurchase,
  });

  final OffersCartModel offer;
  final bool isPurchasing;
  final VoidCallback onPurchase;

  @override
  Widget build(BuildContext context) {
    final title = context.localizedValue(
      en: offer.name,
      ar: offer.arName,
      fallback: '-',
    );

    final desc = context.localizedValue(
      en: offer.description,
      ar: offer.arDescription,
      fallback: '',
    );

    final qty = offer.quantity ?? 0;
    final itemsCount = offer.itemsCount ?? 0;

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_offer_outlined, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if ((offer.isActive ?? 0) == 1)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      tr('offers_cart.active'),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
            if (desc.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                desc,
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _ChipText(
                  label: tr('offers_cart.price'),
                  value: offer.price ?? '-',
                ),
                _ChipText(label: tr('offers_cart.quantity'), value: '$qty'),
                _ChipText(
                  label: tr('offers_cart.items_count'),
                  value: '$itemsCount',
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isPurchasing ? null : onPurchase,
                child: Text(
                  isPurchasing
                      ? tr('offers_cart.purchasing')
                      : tr('offers_cart.purchase'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipText extends StatelessWidget {
  const _ChipText({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _AddressPickerView extends StatelessWidget {
  const _AddressPickerView();

  @override
  Widget build(BuildContext context) {
    final addressCtrl = Get.find<AddressController>();

    return Scaffold(
      appBar: CommonAppBar(title: Text(tr('offers_cart.select_address'))),
      body: Obx(() {
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
              onTap: () => Get.back(result: address),
              child: Opacity(
                opacity: 0.95,
                child: AddressCard(address: address),
              ),
            );
          },
        );
      }),
    );
  }
}
