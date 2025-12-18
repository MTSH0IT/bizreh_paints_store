import 'package:flutter/material.dart';

class SearchFilterDropdown<T> extends StatelessWidget {
  final String label;
  final String allLabel;
  final int? selectedId;
  final bool isLoading;
  final List<T> options;
  final int? Function(T) idOf;
  final String Function(T) titleOf;
  final ValueChanged<int?> onChanged;

  const SearchFilterDropdown({
    super.key,
    required this.label,
    required this.allLabel,
    required this.selectedId,
    required this.isLoading,
    required this.options,
    required this.idOf,
    required this.titleOf,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      initialValue: selectedId,
      isExpanded: true,
      onChanged: isLoading ? null : onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      items: [
        DropdownMenuItem<int?>(value: null, child: Text(allLabel)),
        ...options.map(
          (o) =>
              DropdownMenuItem<int?>(value: idOf(o), child: Text(titleOf(o))),
        ),
      ],
    );
  }
}
