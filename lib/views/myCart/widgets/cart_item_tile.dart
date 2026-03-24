import 'dart:async';

import 'package:bizreh_paints_store/models/cart_model/item.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    this.onDelete,
    this.onSetQuantity,
  });

  final Item item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback? onDelete;
  final Function(int)? onSetQuantity;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  String get _image {
    final optionImage = widget.item.option?.mainImage ?? "";
    return optionImage;
  }

  String? get _colorDegreeValue => widget.item.packaging?.color?.degree;
  bool get _hasColor => (_colorDegreeValue?.trim().isNotEmpty ?? false);
  Color get _colorDegree => parseColorDegree(_colorDegreeValue);

  num get _unitPrice => widget.item.unitPrice ?? 0;
  num get _totalPrice => widget.item.totalPrice ?? 0;
  double get _discountAmount {
    final raw = widget.item.discountAmount;
    return double.tryParse(raw ?? '0') ?? 0;
  }

  int get _quantity => widget.item.quantityPerUnit ?? 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: ImageNetwork(image: _image),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localizedValue(
                    en: widget.item.product?.title,
                    ar: widget.item.product?.arTitle,
                    fallback: '',
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                if (((widget.item.category?.title ?? '').trim().isNotEmpty) ||
                    ((widget.item.category?.arTitle ?? '').trim().isNotEmpty))
                  Text(
                    context.localizedValue(
                      en: widget.item.category?.title,
                      ar: widget.item.category?.arTitle,
                      fallback: '',
                    ),
                  ),
                const SizedBox(height: 2),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (((widget.item.option?.optionName ?? '')
                                .trim()
                                .isNotEmpty) ||
                            ((widget.item.option?.arOptionName ?? '')
                                .trim()
                                .isNotEmpty))
                          Text(
                            context.localizedValue(
                              en: widget.item.option?.optionName,
                              ar: widget.item.option?.arOptionName,
                              fallback: '',
                            ),
                          ),
                        if (((widget.item.packaging?.title ?? '')
                                .trim()
                                .isNotEmpty) ||
                            ((widget.item.packaging?.arTitle ?? '')
                                .trim()
                                .isNotEmpty))
                          Text(
                            context.localizedValue(
                              en: widget.item.packaging?.title,
                              ar: widget.item.packaging?.arTitle,
                              fallback: '',
                            ),
                          ),
                        if (widget.item.productSku != null)
                          Text(widget.item.productSku!),
                        if (_hasColor)
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: ColorDot(
                              color: _colorDegree,
                              selected: false,
                              width: 20,
                              height: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formatPriceWithSymbol(_totalPrice, symbol: '\$'),
                  style: const TextStyle(
                    color: Color(0xFF2F6BFF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (_discountAmount > 0)
                  Text(
                    '- ${formatPriceWithSymbol(_discountAmount, symbol: '\$')}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.onDelete != null)
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      widget.onDelete!();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 30),
                _quantityPill(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityPill() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F7),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _pillIcon(
            icon: Icons.remove,
            onTap: widget.onDecrement,
            filled: false,
            enabled: _quantity > 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: _showQuantityDialog,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),
                ),
                child: Text(
                  _quantity.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          _pillIcon(icon: Icons.add, onTap: widget.onIncrement, filled: true),
        ],
      ),
    );
  }

  Widget _pillIcon({
    required IconData icon,
    required VoidCallback onTap,
    bool filled = false,
    bool enabled = true,
  }) {
    final bgColor = filled ? const Color(0xFF2F6BFF) : Colors.white;
    final iconColor = filled ? Colors.white : Colors.black87;
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: enabled
          ? () {
              HapticFeedback.lightImpact();
              onTap();
            }
          : null,
      child: Opacity(
        opacity: enabled ? 1 : 0.35,
        child: SizedBox(
          width: 28,
          height: 28,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black12),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
        ),
      ),
    );
  }

  Future<void> _showQuantityDialog() async {
    if (widget.onSetQuantity == null) return;
    final controller = TextEditingController(text: _quantity.toString());
    String? errorText;
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                tr('cart.set_new_quantity'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      label: Text(tr('cart.quantity')),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      errorText: errorText,
                      errorMaxLines: 2,
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(tr('cart.cancel')),
                    ),
                    TextButton(
                      onPressed: () {
                        final q = int.tryParse(controller.text);
                        if (q != null && q > 0 && q < 1000) {
                          Navigator.of(context).pop(q);
                        } else {
                          setState(() {
                            errorText = tr('cart.valid_quantity_error');
                          });
                        }
                      },
                      child: Text(tr('cart.ok')),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
    if (result != null && result > 0) {
      widget.onSetQuantity!(result);
    }
  }
}
