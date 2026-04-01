import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<int?> showQuantityInputDialog(
  BuildContext context, {
  int initialQuantity = 1,
}) async {
  return showDialog<int>(
    context: context,
    builder: (context) => QuantityInputDialog(initialQuantity: initialQuantity),
  );
}

class QuantityInputDialog extends StatefulWidget {
  const QuantityInputDialog({super.key, this.initialQuantity = 1});

  final int initialQuantity;

  @override
  State<QuantityInputDialog> createState() => _QuantityInputDialogState();
}

class _QuantityInputDialogState extends State<QuantityInputDialog> {
  late final TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialQuantity < 1 ? 1 : widget.initialQuantity;
    _controller = TextEditingController(text: initial.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    final quantity = int.tryParse(_controller.text.trim());
    if (quantity != null && quantity > 0 && quantity < 1000) {
      Navigator.of(context).pop(quantity);
      return;
    }
    setState(() {
      _errorText = tr('cart.valid_quantity_error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        tr('cart.set_new_quantity'),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        autofocus: true,
        decoration: InputDecoration(
          labelText: tr('cart.quantity'),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          errorText: _errorText,
          errorMaxLines: 2,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('cart.cancel')),
        ),
        TextButton(onPressed: _confirm, child: Text(tr('cart.ok'))),
      ],
    );
  }
}
