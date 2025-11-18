import 'package:bizreh_paints_store/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({super.key, required this.products});

  final List<ItemModel> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          child: ProductsGrid(isNeverScrollable: false, products: products),
        ),
      ),
    );
  }
}
