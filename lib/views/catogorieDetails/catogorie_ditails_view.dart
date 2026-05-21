import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/models/category_tree/category_tree_model.dart';
import 'package:bizreh_paints_store/models/category_tree/category.dart';
import 'package:bizreh_paints_store/models/category_tree/sub_category.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:get/get.dart' hide Trans;

class CatogorieDitailsView extends StatefulWidget {
  const CatogorieDitailsView({super.key, required this.superCategory});

  final CategoryTreeModle superCategory;

  @override
  State<CatogorieDitailsView> createState() => _CatogorieDitailsViewState();
}

class _CatogorieDitailsViewState extends State<CatogorieDitailsView> {
  late List<Category> _categories;

  @override
  void initState() {
    super.initState();
    _categories = widget.superCategory.categories ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        appBar: CommonAppBar(
          backgroundColor: Colors.white,
          title: Text(
            context.localizedValue(
              en: widget.superCategory.title,
              ar: widget.superCategory.arTitle,
              fallback: 'Categories',
            ),
          ),
          bottom: PreferredSize(
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
              tabs: List.generate(
                _categories.length,
                (i) => Tab(
                  text: context.localizedValue(
                    en: _categories[i].title,
                    ar: _categories[i].arTitle,
                    fallback: '',
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: TabBarView(
                children: List.generate(
                  _categories.length,
                  (index) => _SubCategoriesGrid(
                    subCategories: _categories.isNotEmpty
                        ? (_categories[index].subCategories ?? const [])
                        : const [],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubCategoriesGrid extends StatelessWidget {
  const _SubCategoriesGrid({required this.subCategories});

  final List<SubCategory> subCategories;

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) {
      return const Center(child: Text('No sub categories'));
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      itemCount: subCategories.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final sc = subCategories[i];
        return GestureDetector(
          onTap: () {
            Get.find<HomeController>().loadSubCategoryProducts(
              subCategory: sc.id,
            );
            Get.to(
              () => _SubCategoryProducts(
                title: context.localizedValue(
                  en: sc.title,
                  ar: sc.arTitle,
                  fallback: 'Products',
                ),
              ),
            );
          },
          child: ListCategory(sc: sc),
        );
      },
    );
  }
}

class ListCategory extends StatelessWidget {
  const ListCategory({super.key, required this.sc});

  final SubCategory sc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 56,
              height: 56,
              child: ImageNetwork(image: sc.image ?? ''),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localizedValue(
                    en: sc.title,
                    ar: sc.arTitle,
                    fallback: '',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                // Text(
                //   '',
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                //   style: const TextStyle(
                //     color: Colors.black54,
                //     fontSize: 12,
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(6),
            child: Icon(Icons.chevron_right, color: primaryColor),
          ),
        ],
      ),
    );
  }
}

class _SubCategoryProducts extends StatelessWidget {
  _SubCategoryProducts({required this.title});
  final String title;
  final controler = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Obx(() {
              if (controler.isSubCategoryProductsLoading.value) {
                return const BuildProgressIndicator();
              }
              return ProductsGrid(
                products: controler.subCategoryProducts,
                isNeverScrollable: false,
              );
            }),
          ),
        ),
      ),
    );
  }
}
