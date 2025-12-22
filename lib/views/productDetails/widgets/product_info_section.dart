import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:flutter/material.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          "Brand : ${product.brandName}",
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        Text(
          "Category : ${product.subCategoryName}",
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
