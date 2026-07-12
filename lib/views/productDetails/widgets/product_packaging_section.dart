import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/models/product_model/option.dart';
import 'package:bizreh_paints_store/models/product_model/packaging_option.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_option.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/packaging_variants_bottom_sheet.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

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
    final options = product.options ?? [];
    if (options.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            tr('product_details.coming_soon'),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return Obx(() {
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
        final key = context
            .localizedValue(
              en: pkg.packagingTitle,
              ar: pkg.arPackagingTitle,
              fallback: '',
            )
            .trim();
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
        selectedGroupKey = context
            .localizedValue(
              en: selectedPackagingModel.packagingTitle,
              ar: selectedPackagingModel.arPackagingTitle,
              fallback: '',
            )
            .trim();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('product_details.packaging'),
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
          const SizedBox(height: 16),
          if (selectedPackagingModel != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('product_details.price'),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          //const SizedBox(height: 4),
                        ],
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 12,
                      //     vertical: 6,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: (selectedPackagingModel.stockQuantity ?? 0) > 0
                      //         ? Colors.green.shade50
                      //         : Colors.red.shade50,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      // child: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     Container(
                      //       width: 8,
                      //       height: 8,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color:
                      //             (selectedPackagingModel.stockQuantity ??
                      //                     0) >
                      //                 0
                      //             ? Colors.green
                      //             : Colors.red,
                      //       ),
                      //     ),
                      //     const SizedBox(width: 6),
                      //     Text(
                      //       (selectedPackagingModel.stockQuantity ?? 0) > 0
                      //           ? '${tr('product_details.stock')}: ${selectedPackagingModel.stockQuantity}'
                      //           : tr('product_details.out_of_stock'),
                      //       style: TextStyle(
                      //         color:
                      //             (selectedPackagingModel.stockQuantity ??
                      //                     0) >
                      //                 0
                      //             ? Colors.green.shade800
                      //             : Colors.red.shade800,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 12,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //),
                      Text(
                        formatPrice(selectedPackagingModel.pricePerUnit ?? 0),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (selectedPackagingModel.color != null) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(color: Colors.black12, height: 1),
                    ),
                    Row(
                      children: [
                        ColorDot(
                          color: parseColorDegree(
                            selectedPackagingModel.color!.degree,
                          ),
                          selected: true,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            context.localizedValue(
                              en: selectedPackagingModel.color!.name,
                              ar: selectedPackagingModel.color!.arName,
                              fallback: '',
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      );
    });
  }
}
