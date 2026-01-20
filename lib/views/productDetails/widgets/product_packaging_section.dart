import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/models/product_model/option.dart';
import 'package:bizreh_paints_store/models/product_model/packaging_option.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_option.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/packaging_variants_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPackagingSection extends StatelessWidget {
  const ProductPackagingSection({
    super.key,
    required this.product,
    required this.controller,
  });

  final ProductModel product;
  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final options = product.options ?? [];
      if (options.isEmpty) {
        return const SizedBox.shrink();
      }

      final selectedOptionId = controller.selectedOption.value;
      if (selectedOptionId < 0) {
        return const SizedBox.shrink();
      }

      Option? selectedOptionModel;
      for (final o in options) {
        if (o.id == selectedOptionId) {
          selectedOptionModel = o;
          break;
        }
      }

      if (selectedOptionModel == null ||
          (selectedOptionModel.packagingOptions ?? []).isEmpty) {
        return const SizedBox.shrink();
      }

      final packagingList = selectedOptionModel.packagingOptions!;

      final grouped = <String, List<PackagingOption>>{};
      for (final pkg in packagingList) {
        final key = (pkg.packagingTitle ?? pkg.arPackagingTitle ?? '').trim();
        if (key.isEmpty) continue;
        grouped.putIfAbsent(key, () => <PackagingOption>[]).add(pkg);
      }

      final groupedKeys = grouped.keys.toList();

      final selectedPackagingId = controller.selectedPackaging.value;
      PackagingOption? selectedPackagingModel;
      for (final pkg in packagingList) {
        if (pkg.id == selectedPackagingId) {
          selectedPackagingModel = pkg;
          break;
        }
      }

      String? selectedGroupKey;
      if (selectedPackagingModel != null) {
        selectedGroupKey =
            (selectedPackagingModel.packagingTitle ??
                    selectedPackagingModel.arPackagingTitle ??
                    '')
                .trim();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Packaging :',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(groupedKeys.length, (index) {
              final key = groupedKeys[index];
              final selected = key == selectedGroupKey;
              return ProductOption(
                title: key,
                selected: selected,
                onTap: () {
                  final variants = grouped[key] ?? <PackagingOption>[];
                  if (variants.isEmpty) return;

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (_) => PackagingVariantsBottomSheet(
                      title: key,
                      variants: variants,
                      selectedPackagingId: controller.selectedPackaging.value,
                      onSelect: (v) {
                        if (v.id == null) return;
                        controller.selectPackaging(
                          v.id!,
                          colorFamilyId: v.color?.id,
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 8),
          if (selectedPackagingModel != null)
            Text(
              'Price: ${formatPrice(selectedPackagingModel.pricePerUnit ?? 0)}',
              style: const TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          if (selectedPackagingModel != null)
            Text(
              'Stock: ${selectedPackagingModel.stockQuantity ?? 0}',
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          const SizedBox(height: 8),

          if (selectedPackagingModel != null &&
              selectedPackagingModel.color != null)
            Row(
              children: [
                ColorDot(
                  color: parseColorDegree(selectedPackagingModel.color!.degree),
                  selected: true,
                ),
                const SizedBox(width: 10),
                Text(
                  selectedPackagingModel.color!.name ?? '',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
        ],
      );
    });
  }
}
