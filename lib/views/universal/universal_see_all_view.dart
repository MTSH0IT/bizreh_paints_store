import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/app_refresh_wrapper.dart';
import 'package:flutter/material.dart';

class UniversalSeeAllView<T> extends StatefulWidget {
  const UniversalSeeAllView({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.listItemBuilder,
    this.onRefresh,
    this.isLoading = false,
    this.emptyMessage = 'No items found',
    this.useGridView = false,
    this.gridDelegate,
    this.padding,
  });

  final String title;
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context, T item, int index)
  listItemBuilder;
  final Future<void> Function()? onRefresh;
  final bool isLoading;
  final String emptyMessage;
  final bool useGridView;
  final SliverGridDelegate? gridDelegate;
  final EdgeInsets? padding;

  @override
  State<UniversalSeeAllView<T>> createState() => _UniversalSeeAllViewState<T>();
}

class _UniversalSeeAllViewState<T> extends State<UniversalSeeAllView<T>> {
  late bool _useGridView;

  @override
  void initState() {
    super.initState();
    _useGridView = widget.useGridView;
  }

  void _toggleView() {
    setState(() {
      _useGridView = !_useGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent();

    return Scaffold(
      appBar: CommonAppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(_useGridView ? Icons.view_list : Icons.grid_view),
            onPressed: _toggleView,
            tooltip: _useGridView ? 'Switch to List' : 'Switch to Grid',
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: widget.onRefresh != null
                ? AppRefreshWrapper(
                    onRefresh: widget.onRefresh!,
                    child: content,
                  )
                : content,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.isLoading && widget.items.isEmpty) {
      return const BuildProgressIndicator();
    }

    if (widget.items.isEmpty) {
      return Builder(builder: (context) => _buildEmptyState(context));
    }

    if (_useGridView) {
      return _buildGridView();
    } else {
      return _buildListView();
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          widget.emptyMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate:
          widget.gridDelegate ??
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return widget.itemBuilder(context, widget.items[index], index);
      },
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: widget.items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return widget.listItemBuilder(context, widget.items[index], index);
      },
    );
  }
}
