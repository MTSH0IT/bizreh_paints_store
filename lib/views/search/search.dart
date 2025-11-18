import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/views/search/widgets/filter_button.dart';
import 'package:bizreh_paints_store/views/search/widgets/search_input.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  String? selectedBrand;
  String? selectedCategory;

  final List<String> brands = [
    'All Brands',
    'Dulux',
    'Nippon',
    'Jotun',
    'Sikkens',
    'Beckers',
    'Crown',
    'Farrow & Ball',
  ];

  final List<String> categories = [
    'All Categories',
    'Interior Paint',
    'Exterior Paint',
    'Primer',
    'Varnish',
    'Wood Stain',
    'Metal Paint',
    'Specialty Paint',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    selectedBrand = brands.first;
    selectedCategory = categories.first;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SearchInput(
                controller: _controller,
                onClear: () {
                  _controller.clear();
                },
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FilterButton(
                      label: 'Brand',
                      selectedValue: selectedBrand,
                      items: brands,
                      onChanged: (value) {
                        setState(() {
                          selectedBrand = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilterButton(
                      label: 'Category',
                      selectedValue: selectedCategory,
                      items: categories,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '1,284 Results',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Text(
                        'Sort by: ',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18,
                        ),
                        label: const Text(
                          'Relevance',
                          style: TextStyle(color: primaryColor),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            //Expanded(child: SingleChildScrollView(child: ProductsGrid())),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
