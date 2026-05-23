import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/app_refresh_wrapper.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'widgets/wish_list_item.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:bizreh_paints_store/utils/widgets/quantity_input_dialog.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<WishListController>();
    return Obx(() {
      if (ctrl.isGetLoading.value) {
        return Scaffold(
          appBar: CommonAppBar(titleKey: 'wishlist.title'),
          body: const BuildProgressIndicator(),
        );
      }

      List<_WishlistTab> buildTabs() {
        final List<_WishlistTab> tabs = [
          const _WishlistTab(id: null, title: 'All', arTitle: 'الجميع'),
        ];
        final Set<int> seen = <int>{};

        for (final item in ctrl.items) {
          final subCategoryName = item.product?.categories?.subCategory;
          final subCategoryId = item.product?.subCategoryId;
          if (subCategoryId == null || seen.contains(subCategoryId)) continue;

          seen.add(subCategoryId);

          tabs.add(
            _WishlistTab(
              id: subCategoryId,
              title: subCategoryName?.name ?? "subCategoryName $subCategoryId",
              arTitle:
                  subCategoryName?.arName ?? "اسم الفئة الفرعية $subCategoryId",
            ),
          );
        }

        return tabs;
      }

      final List<_WishlistTab> tabs = buildTabs();
      final bool hasItems = ctrl.items.isNotEmpty;

      return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: CommonAppBar(
            titleKey: 'wishlist.title',
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: tr('wishlist.clear_all'),
                onPressed: () {
                  if (ctrl.items.isEmpty) {
                    showMassage(tr('wishlist.empty_snackbar'), false);
                    return;
                  }
                  ctrl.clearAll();
                },
              ),
            ],
            bottom: hasItems
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: TabBar(
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.grey[700],
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      indicatorColor: primaryColor,
                      indicatorWeight: 2.0,
                      tabs: tabs
                          .map(
                            (tab) => Tab(
                              text: context.localizedValue(
                                en: tab.title,
                                ar: tab.arTitle,
                                fallback: 'Category ${tab.id.toString()}',
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : null,
          ),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: hasItems
                    ? TabBarView(
                        children: List.generate(tabs.length, (index) {
                          final int? tabId = tabs[index].id;
                          final filteredItems = tabId == null
                              ? ctrl.items
                              : ctrl.items.where((item) {
                                  final subCategoryid =
                                      item.product?.subCategoryId;
                                  return subCategoryid != null &&
                                      subCategoryid == tabId;
                                }).toList();
                          return AppRefreshWrapper(
                            onRefresh: ctrl.loadWishListProducts,
                            child: filteredItems.isEmpty
                                ? ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: [
                                      SizedBox(
                                        height: 240,
                                        child: Center(
                                          child: Text(
                                            context.localizedValue(
                                              en: 'No items in this category',
                                              ar: 'لا توجد عناصر في هذه الفئة',
                                              fallback: 'No items',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    itemCount: filteredItems.length,
                                    itemBuilder: (context, index) {
                                      final item = filteredItems[index];
                                      return GestureDetector(
                                        onTap: () {
                                          //  Get.to(() => ProductDetailsView(product: item));
                                        },
                                        child: WishListItemCard(
                                          item: item,
                                          onMoveToCart: () async {
                                            final quantity =
                                                await showQuantityInputDialog(
                                                  context,
                                                );
                                            if (quantity == null) return;
                                            await ctrl.addWishlistItemToCart(
                                              item,
                                              quantity: quantity,
                                            );
                                          },
                                          onRemove: () {
                                            ctrl.removeItem(
                                              item.optionPackagingId!,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                          );
                        }),
                      )
                    : AppRefreshWrapper(
                        onRefresh: ctrl.loadWishListProducts,
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 240,
                              child: Center(child: Text(tr('wishlist.empty'))),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _WishlistTab {
  final int? id;
  final String title;
  final String arTitle;

  const _WishlistTab({this.id, required this.title, required this.arTitle});
}
