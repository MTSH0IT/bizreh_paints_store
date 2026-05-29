import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class LoadingDropdownFormField2<T> extends StatefulWidget {
  final bool isLoading;
  final List<DropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String labelText;
  final String hintText;
  final bool enableSearch;
  final String searchHintText;
  final double? menuItemHeight;
  final String Function(DropdownItem<T> item)? selectedItemTextBuilder;

  const LoadingDropdownFormField2({
    super.key,
    required this.isLoading,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelText,
    required this.hintText,
    this.enableSearch = false,
    this.searchHintText = 'Search...',
    this.menuItemHeight,
    this.selectedItemTextBuilder,
  });

  @override
  State<LoadingDropdownFormField2<T>> createState() =>
      _LoadingDropdownFormField2State<T>();
}

class _LoadingDropdownFormField2State<T>
    extends State<LoadingDropdownFormField2<T>> {
  late final TextEditingController _searchController;
  late final ValueNotifier<T?> _selectedValueNotifier;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedValueNotifier = ValueNotifier<T?>(_getEffectiveValue());
  }

  @override
  void didUpdateWidget(covariant LoadingDropdownFormField2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value || oldWidget.items != widget.items) {
      _selectedValueNotifier.value = _getEffectiveValue();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _selectedValueNotifier.dispose();
    super.dispose();
  }

  T? _getEffectiveValue() {
    return widget.items.any((e) => e.value == widget.value)
        ? widget.value
        : null;
  }

  String _itemText(DropdownItem<T> item) {
    final child = item.child;
    if (child is Text) {
      return child.data ?? child.textSpan?.toPlainText() ?? '';
    }
    return item.value?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final DropdownSearchData<T>? dropdownSearchData = widget.enableSearch
        ? DropdownSearchData<T>(
            searchController: _searchController,
            searchBarWidgetHeight: 60,
            searchBarWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: TextFormField(
                controller: _searchController,
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.searchHintText,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 18,
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            searchMatchFn: (DropdownItem<T> item, String searchValue) {
              final text = _itemText(item);
              return text.toLowerCase().contains(searchValue.toLowerCase());
            },
          )
        : null;

    return DropdownButtonFormField2<T>(
      valueListenable: _selectedValueNotifier,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.only(
          left: 0,
          right: 0,
          top: 10,
          bottom: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
      ),
      hint: widget.isLoading
          ? const Text('Loading...', style: TextStyle(fontSize: 13))
          : Text(
              widget.hintText,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
      items: widget.items,
      selectedItemBuilder: widget.selectedItemTextBuilder == null
          ? null
          : (context) => widget.items.map((item) {
              final text = widget.selectedItemTextBuilder!(item);
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
              );
            }).toList(),
      onChanged: widget.isLoading
          ? null
          : (val) {
              _selectedValueNotifier.value = val;
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
      dropdownSearchData: dropdownSearchData,
      iconStyleData: const IconStyleData(
        icon: Padding(
          padding: EdgeInsets.zero,
          child: Icon(Icons.arrow_drop_down, size: 20),
        ),
      ),
      buttonStyleData: const FormFieldButtonStyleData(
        padding: EdgeInsets.zero,
        height: 50,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
