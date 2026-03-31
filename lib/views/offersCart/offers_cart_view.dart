import 'package:bizreh_paints_store/controllers/offers_cart_controller.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/models/offers_cart_model/offers_cart_model.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/app_refresh_wrapper.dart';
import 'package:bizreh_paints_store/views/offersCart/offers_cart_details_view.dart';
import 'package:bizreh_paints_store/views/offersCart/widgets/offers_cart_address_picker_view.dart';
import 'package:bizreh_paints_store/views/offersCart/widgets/offers_cart_offer_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class OffersCartView extends StatelessWidget {
  const OffersCartView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<OffersCartController>();

    return Scaffold(
      appBar: CommonAppBar(title: Text(tr('offers_cart.title'))),
      body: Obx(() {
        final isLoading = ctrl.isLoadingOffers.value;
        final offers = ctrl.offers;

        if (isLoading && offers.isEmpty) {
          return const BuildProgressIndicator();
        }

        return AppRefreshWrapper(
          onRefresh: ctrl.loadOffers,
          child: offers.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 240,
                      child: Center(child: Text(tr('offers_cart.no_offers'))),
                    ),
                  ],
                )
              : SafeArea(
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: offers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final offer = offers[i];
                      return OffersCartOfferCard(
                        offer: offer,
                        isPurchasing: ctrl.purchasingOfferId.value == offer.id,
                        onPurchase: () => _purchase(context, offer),
                        onViewDetails: () {
                          Get.to(() => OffersCartDetailsView(offer: offer));
                        },
                      );
                    },
                  ),
                ),
        );
      }),
    );
  }

  Future<void> _purchase(BuildContext context, OffersCartModel offer) async {
    if (offer.id == null) return;

    final address = await Get.to<AddressModel?>(
      () => const OffersCartAddressPickerView(),
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
    var inputValue = '1';

    final result = await Get.dialog<int>(
      AlertDialog(
        title: Text(tr('offers_cart.enter_quantity')),
        content: TextFormField(
          initialValue: '1',
          onChanged: (value) => inputValue = value,
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
              final parsed = int.tryParse(inputValue.trim());
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

    return result;
  }
}
