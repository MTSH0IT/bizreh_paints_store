import 'package:bizreh_paints_store/models/product_model/packaging_option.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PackagingVariantsBottomSheet extends StatelessWidget {
  const PackagingVariantsBottomSheet({
    super.key,
    required this.title,
    required this.variants,
    required this.selectedPackagingId,
    required this.onSelect,
  });

  final String title;
  final List<PackagingOption> variants;
  final int selectedPackagingId;
  final void Function(PackagingOption option) onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: variants.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final v = variants[i];
                      final isSelected = v.id == selectedPackagingId;
                      return InkWell(
                        onTap: v.id == null
                            ? null
                            : () {
                                onSelect(v);
                                Navigator.of(context).pop();
                              },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              width: isSelected ? 1.8 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: v.color != null
                                    ? ColorDot(
                                        color: parseColorDegree(
                                          v.color!.degree,
                                        ),
                                        selected: isSelected,
                                      )
                                    : Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey.withValues(
                                              alpha: 0.07,
                                            ),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (v.color != null)
                                      Text(
                                        context.localizedValue(
                                          en: v.color!.name,
                                          ar: v.color!.arName,
                                          fallback: '',
                                        ),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    if (v.optionSku != null &&
                                        v.optionSku!.isNotEmpty)
                                      Text(
                                        'SKU: ${v.optionSku}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    Text(
                                      '${tr('product_details.price')}: ${formatPrice(v.pricePerUnit ?? 0)}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      '${tr('product_details.stock')}: ${v.stockQuantity ?? 0}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
