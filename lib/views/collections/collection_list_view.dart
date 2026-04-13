import 'package:bizreh_paints_store/controllers/collection_controllers.dart';
import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/views/collections/widgets/collection_empty_state.dart';
import 'package:bizreh_paints_store/views/collections/widgets/collection_child_tab_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class CollectionListView extends StatelessWidget {
  const CollectionListView({super.key, required this.parentId});

  final int parentId;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CollectionControllers>();

    return Obx(() {
      final CollectionModel? parent = ctrl.collections
          .cast<CollectionModel?>()
          .firstWhere((e) => e?.id == parentId, orElse: () => null);

      if (parent == null) {
        return Scaffold(
          appBar: CommonAppBar(title: Text(tr('home.collections'))),
          body: const SafeArea(
            child: Center(child: Text('Collection not found')),
          ),
        );
      }

      final String appBarTitle = context.localizedValue(
        en: parent.title,
        ar: parent.arTitle,
        fallback: tr('home.collections'),
      );

      final children = parent.subCollections ?? <CollectionModel>[];

      if (children.isEmpty) {
        final products = parent.products ?? const [];
        final hasProducts = products.isNotEmpty;

        return Scaffold(
          appBar: CommonAppBar(title: Text(appBarTitle)),
          body: SafeArea(
            child: hasProducts
                ? ProductsGrid(products: products, isNeverScrollable: false)
                : const CollectionEmptyState(),
          ),
        );
      }

      return DefaultTabController(
        length: children.length,
        child: Scaffold(
          appBar: CommonAppBar(title: Text(appBarTitle)),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _ChildrenTabBar(children: children),
                const SizedBox(height: 8),
                Expanded(
                  child: TabBarView(
                    children: children
                        .map((child) => CollectionChildTabBody(root: child))
                        .toList(growable: false),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _ChildrenTabBar extends StatelessWidget {
  const _ChildrenTabBar({required this.children});

  final List<CollectionModel> children;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        isScrollable: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: children
            .map(
              (e) => Tab(
                child: Text(
                  context.localizedValue(
                    en: e.title,
                    ar: e.arTitle,
                    fallback: '',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}
