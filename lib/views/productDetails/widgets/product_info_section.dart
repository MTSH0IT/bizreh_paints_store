import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:easy_localization/easy_localization.dart';
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
          context.localizedValue(
            en: product.title,
            ar: product.arTitle,
            fallback: '',
          ),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          "${tr('product_details.brand')} : ${context.localizedValue(en: product.brandName, ar: product.arBrandName, fallback: '')}",
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        Text(
          "${tr('product_details.category')} : ${context.localizedValue(en: product.subCategoryName, ar: product.arSubCategoryName, fallback: '')}",
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
