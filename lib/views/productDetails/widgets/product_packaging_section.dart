import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/models/product_model/option.dart';
import 'package:bizreh_paints_store/models/product_model/packaging.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_option.dart';
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

  Color parseColorDegree(dynamic degree) {
    if (degree == null) return Colors.white;
    if (degree is int) return Color(degree);
    if (degree is String) {
      final v = degree.trim();
      final normalized = v.startsWith('#') ? v.substring(1) : v;
      final hex = normalized.startsWith('0x')
          ? normalized.substring(2)
          : normalized;
      final value = int.tryParse(hex, radix: 16);
      if (value == null) return Colors.grey;
      if (hex.length <= 6) {
        return Color(0xFF000000 | value);
      }
      return Color(value);
    }
    return Colors.grey;
  }

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
          (selectedOptionModel.packaging ?? []).isEmpty) {
        return const SizedBox.shrink();
      }

      final packagingList = selectedOptionModel.packaging!;

      final selectedPackagingId = controller.selectedPackaging.value;
      Packaging? selectedPackagingModel;
      for (final pkg in packagingList) {
        if (pkg.id == selectedPackagingId) {
          selectedPackagingModel = pkg;
          break;
        }
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
            children: List.generate(packagingList.length, (index) {
              final pkg = packagingList[index];
              final selected = pkg.id == controller.selectedPackaging.value;
              final title = pkg.packagingTitle ?? '';
              return ProductOption(
                title: title,
                selected: selected,
                onTap: () => controller.selectPackaging(pkg.id!),
              );
            }),
          ),
          const SizedBox(height: 16),
          if (selectedPackagingModel != null)
            Text(
              'Price: ${formatPrice(selectedPackagingModel.pricePerUnit ?? 0)}',
              style: const TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          const SizedBox(height: 16),

          Obx(() {
            final selectedPackagingId = controller.selectedPackaging.value;
            if (selectedPackagingId < 0) {
              return const SizedBox.shrink();
            }

            final allColors = selectedOptionModel!.colorFamilies ?? [];
            final colors = allColors
                .where((c) => c.optionPackagingId == selectedPackagingId)
                .toList();
            final selectedColorId = controller.selectedColorId.value;

            if (colors.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Colors :',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      final c = colors[index];
                      final id = c.id ?? -1;
                      final selected = id == selectedColorId;

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: id < 0
                              ? null
                              : () => controller.selectColor(id),
                          child: ColorDot(
                            color: parseColorDegree(c.colorDegree),
                            selected: selected,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ],
      );
    });
  }
}
