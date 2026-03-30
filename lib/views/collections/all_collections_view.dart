import 'package:bizreh_paints_store/controllers/collection_controllers.dart';
import 'package:bizreh_paints_store/utils/widgets/app_refresh_wrapper.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/views/collections/collections_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class AllCollectionsView extends StatelessWidget {
  const AllCollectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionControllers controller = Get.find<CollectionControllers>();

    return Scaffold(
      appBar: CommonAppBar(
        title: Obx(() {
          final parentsCount = controller.collections
              .where((item) => item.parentCollectionId == null)
              .length;
          return Text('${tr('home.collections')}  ($parentsCount)');
        }),
      ),
      body: SafeArea(
        child: AppRefreshWrapper(
          onRefresh: controller.getCollections,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: const CollectionsSection(),
          ),
        ),
      ),
    );
  }
}
