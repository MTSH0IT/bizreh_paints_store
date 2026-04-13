import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/views/collections/widgets/collection_sub_collection_tile.dart';
import 'package:bizreh_paints_store/views/collections/widgets/collection_empty_state.dart';
import 'package:flutter/material.dart';

class CollectionChildTabBody extends StatefulWidget {
  const CollectionChildTabBody({super.key, required this.root});

  final CollectionModel root;

  @override
  State<CollectionChildTabBody> createState() => _CollectionChildTabBodyState();
}

class _CollectionChildTabBodyState extends State<CollectionChildTabBody>
    with AutomaticKeepAliveClientMixin {
  final List<CollectionModel> _navigationStack = [];

  CollectionModel get _displayNode {
    if (_navigationStack.isEmpty) return widget.root;
    return _navigationStack.last;
  }

  bool get _canGoBack => _navigationStack.isNotEmpty;

  void _navigateTo(CollectionModel node) {
    setState(() {
      _navigationStack.add(node);
    });
  }

  void _navigateBack() {
    if (_navigationStack.isEmpty) return;
    setState(() {
      _navigationStack.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final displayNode = _displayNode;
    final subCollections = displayNode.subCollections ?? <CollectionModel>[];
    final products = displayNode.products ?? const [];

    final bool hasProducts = products.isNotEmpty;
    final bool hasSubCollections = subCollections.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_canGoBack) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: _navigateBack,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.08),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, size: 18),
                    SizedBox(width: 8),
                    Text('رجوع'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Expanded(
          child: hasProducts
              ? ProductsGrid(products: products, isNeverScrollable: false)
              : hasSubCollections
              ? _buildChildrenList(subCollections)
              : const CollectionEmptyState(),
        ),
      ],
    );
  }

  Widget _buildChildrenList(List<CollectionModel> children) {
    if (children.isEmpty) {
      return const CollectionEmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: children.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final child = children[i];
        return CollectionSubCollectionTile(
          item: child,
          onTap: () {
            final hasChildren = (child.subCollections?.isNotEmpty ?? false);
            final hasProducts = (child.products?.isNotEmpty ?? false);
            if (hasChildren || hasProducts) {
              _navigateTo(child);
            }
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
