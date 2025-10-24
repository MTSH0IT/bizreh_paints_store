import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const FilterButton({
    super.key,
    required this.label,
    this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: selectedValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          );
        }).toList(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
        isExpanded: true,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
