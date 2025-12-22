import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDescriptionSection extends StatelessWidget {
  const ProductDescriptionSection({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'description :',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        SizedBox(height: 4),
        Text(
          product.description ?? "",
          style: TextStyle(color: Colors.black, height: 2, fontSize: 14),
        ),
      ],
    );
  }
}
