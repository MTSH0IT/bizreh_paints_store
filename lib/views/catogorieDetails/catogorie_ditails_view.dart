import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:flutter/material.dart';

class CatogorieDitailsView extends StatefulWidget {
  const CatogorieDitailsView({super.key});

  @override
  State<CatogorieDitailsView> createState() => _CatogorieDitailsViewState();
}

class _CatogorieDitailsViewState extends State<CatogorieDitailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    "Interior",
    "Exterior",
    "Primers",
    "Stains",
    "Supplies",
    "Specialty",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Categories'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: primaryColor,
            unselectedLabelColor: Colors.grey[700],
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            indicatorColor: primaryColor,
            indicatorWeight: 2.0,
            tabs: _tabs.map((t) => Tab(text: t)).toList(),
          ),
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: _tabs
              .map((t) => ProductsGrid(isNeverScrollable: false))
              .toList(),
        ),
      ),
    );
  }
}
