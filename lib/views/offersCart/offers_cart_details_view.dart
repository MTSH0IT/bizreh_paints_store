import 'package:bizreh_paints_store/models/offers_cart_model/item.dart';
import 'package:bizreh_paints_store/models/offers_cart_model/offers_cart_model.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/views/offersCart/widgets/offers_cart_item_tile.dart';
import 'package:bizreh_paints_store/views/offersCart/widgets/offers_cart_offer_details_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OffersCartDetailsView extends StatelessWidget {
  const OffersCartDetailsView({
    super.key,
    required this.offer,
  });

  final OffersCartModel offer;

  @override
  Widget build(BuildContext context) {
    final List<Item> items = offer.items ?? <Item>[];

    return Scaffold(
      appBar: CommonAppBar(title: Text(tr('offers_cart.details_title'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            OffersCartOfferDetailsCard(offer: offer),
            const SizedBox(height: 14),
            Text(
              tr('offers_cart.included_items'),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            if (items.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(tr('offers_cart.no_items')),
                ),
              )
            else
              ...items.map((item) => OffersCartItemTile(item: item)),
          ],
        ),
      ),
    );
  }
}
