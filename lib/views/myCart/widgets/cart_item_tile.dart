import 'dart:async';

import 'package:bizreh_paints_store/models/cart_model/item.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    this.onSetQuantity,
  });

  final Item item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Function(int)? onSetQuantity;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  String get _image {
    final optionImage = widget.item.option?.mainImage ?? "";
    return optionImage;
  }

  String get _title {
    final product = widget.item.product?.title ?? "";
    return product;
  }

  String? get _optionName {
    final option = widget.item.option?.optionName ?? "";
    return option;
  }

  String? get _packagingTitle {
    final packaging = widget.item.packaging?.title ?? "";
    return packaging;
  }

  String? get _categoryTitle {
    final category = widget.item.category?.title ?? "";
    return category;
  }

  String? get _colorDegreeValue => widget.item.colorFamily?.colorDegree;
  bool get _hasColor => (_colorDegreeValue?.trim().isNotEmpty ?? false);
  Color get _colorDegree => parseColorDegree(_colorDegreeValue);

  double get _unitPrice => widget.item.unitPrice ?? 0.0;
  int get _quantity => widget.item.quantityPerUnit ?? 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ImageNetwork(image: _image),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                if (_optionName != null)
                  Text(
                    _optionName!,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (_packagingTitle != null)
                  Text(
                    _packagingTitle!,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (_categoryTitle != null)
                  Text(
                    _categoryTitle!,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 2),

                Text(
                  'unitPrice : \$${formatPrice(_unitPrice)}',
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    _circleIcon(
                      icon: Icons.remove,
                      onTap: widget.onDecrement,
                      repeatWhile: () => _quantity > 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: GestureDetector(
                        onTap: _showQuantityDialog,
                        child: Text(
                          _quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    _circleIcon(
                      icon: Icons.add,
                      onTap: widget.onIncrement,
                      filled: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ColorDot(color: _colorDegree, selected: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIcon({
    required IconData icon,
    required VoidCallback onTap,
    bool filled = false,
    bool Function()? repeatWhile,
  }) {
    return InkWell(
      customBorder: const CircleBorder(),
      splashColor: primaryColor.withValues(alpha: 0.15),
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: SizedBox(
        width: 28,
        height: 28,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: filled ? primaryColor : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black12),
          ),
          child: Icon(
            icon,
            size: 16,
            color: filled ? Colors.white : Colors.black87,
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
              title: const Text(
                'Set new quantity',
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
                      label: const Text('Quantity'),
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
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        final q = int.tryParse(controller.text);
                        if (q != null && q > 0 && q < 1000) {
                          Navigator.of(context).pop(q);
                        } else {
                          setState(() {
                            errorText =
                                'Please enter a valid number\\nbetween 1 and 999';
                          });
                        }
                      },
                      child: const Text('OK'),
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
