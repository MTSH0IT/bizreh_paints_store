import 'package:bizreh_paints_store/controllers/filter_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/views/search/widgets/search_filter_dropdown.dart';
import 'package:bizreh_paints_store/views/search/widgets/search_input.dart';
import 'package:get/get.dart' hide Trans;

class Search extends StatelessWidget {
  Search({super.key});

  final _searchController = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: SearchInput(
                    controller: _searchController.queryController,
                    onClear: () {
                      _searchController.queryController.clear();
                    },
                    onSubmitted: (_) => _searchController.search(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => SearchFilterDropdown(
                                  label: tr('search.brand'),
                                  allLabel: tr('search.all_brands'),
                                  selectedId:
                                      _searchController.selectedBrandId.value,
                                  isLoading:
                                      _searchController.isOptionsLoading.value,
                                  options: _searchController.brands,
                                  idOf: (b) => b.id,
                                  titleOf: (b) => context.localizedValue(
                                    en: b.title,
                                    ar: b.arTitle,
                                    fallback: '',
                                  ),
                                  onChanged: _searchController.setBrand,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => SearchFilterDropdown(
                                  label: tr('search.category'),
                                  allLabel: tr('search.all_categories'),
                                  selectedId: _searchController
                                      .selectedSubCategoryId
                                      .value,
                                  isLoading:
                                      _searchController.isOptionsLoading.value,
                                  options: _searchController.subCategories,
                                  idOf: (c) => c.id,
                                  titleOf: (c) => context.localizedValue(
                                    en: c.title,
                                    ar: c.arTitle,
                                    fallback: '',
                                  ),
                                  onChanged: _searchController.setSubCategory,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 46,
                                child: Obx(
                                  () => ElevatedButton.icon(
                                    onPressed:
                                        _searchController.isSearching.value
                                        ? null
                                        : () {
                                            FocusScope.of(context).unfocus();
                                            _searchController.search();
                                          },
                                    icon: const Icon(Icons.search_rounded),
                                    label: Text(
                                      _searchController.isSearching.value
                                          ? tr('search.searching')
                                          : tr('search.search'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => _searchController.isOptionsLoading.value
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: LinearProgressIndicator(minHeight: 2),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),

                // const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          '${_searchController.results.length} ${tr('search.results')}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Obx(
                        () => TextButton(
                          onPressed: _searchController.isSearching.value
                              ? null
                              : () {
                                  _searchController.clearFilters();
                                },
                          child: Text(
                            tr('search.clear_results'),
                            style: const TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //const SizedBox(height: 8),
                Expanded(
                  child: Obx(() {
                    if (_searchController.isSearching.value &&
                        _searchController.results.isEmpty) {
                      return const BuildProgressIndicator();
                    }

                    if (_searchController.results.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            tr('search.no_results'),
                            style: TextStyle(color: Colors.grey.shade700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return ProductsGrid(
                      products: _searchController.results,
                      isNeverScrollable: false,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
