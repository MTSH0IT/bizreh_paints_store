import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_option.dart'
    as option_widget;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class ProductOptionsSection extends StatelessWidget {
  const ProductOptionsSection({
    super.key,
    required this.product,
    required this.controller,
  });

  final ProductModel product;
  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    if ((product.options ?? []).isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Options :',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Obx(() {
          final options = product.options!;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(options.length, (i) {
              final option = options[i];
              final selected = option.id == controller.selectedOption.value;

              return option_widget.ProductOption(
                title: context.localizedValue(
                  en: option.optionName,
                  ar: option.arOptionName,
                  fallback: '',
                ),
                selected: selected,
                onTap: () => controller.selectOption(option.id!),
              );
            }),
          );
        }),
      ],
    );
  }
}
