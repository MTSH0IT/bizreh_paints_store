import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.onSetQuantity,
    this.optionName,
    this.packagingTitle,
  });

  final String image;
  final String title;
  final double price;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Function(int)? onSetQuantity;
  final String? optionName;
  final String? packagingTitle;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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
              child: ImageNetwork(image: widget.image),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                if (widget.optionName != null || widget.packagingTitle != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.optionName != null)
                        Text(
                          widget.optionName!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (widget.packagingTitle != null)
                        Text(
                          widget.packagingTitle!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                const SizedBox(height: 2),
                Text(
                  '\$${formatPrice(widget.price)}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
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
                  repeatWhile: () => widget.quantity > 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: _showQuantityDialog,
                    child: Text(
                      widget.quantity.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.lightImpact();
        timer?.cancel();
        timer = Timer.periodic(const Duration(milliseconds: 120), (_) {
          if (repeatWhile == null || repeatWhile()) {
            onTap();
          } else {
            timer?.cancel();
            timer = null;
          }
        });
      },
      onLongPressUp: () {
        timer?.cancel();
        timer = null;
      },
      onTapCancel: () {
        timer?.cancel();
        timer = null;
      },

      child: InkWell(
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
      ),
    );
  }

  Future<void> _showQuantityDialog() async {
    if (widget.onSetQuantity == null) return;
    final controller = TextEditingController(text: widget.quantity.toString());
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
                                'Please enter a valid number\nbetween 1 and 999';
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
