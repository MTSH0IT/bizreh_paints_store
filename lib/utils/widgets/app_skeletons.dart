import 'package:bizreh_paints_store/models/ads_model.dart';
import 'package:bizreh_paints_store/models/category_tree/category_tree_model.dart';
import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/views/collections/widgets/collection_parent_card.dart';
import 'package:bizreh_paints_store/views/home/widgets/bulletin_board.dart';
import 'package:bizreh_paints_store/views/home/widgets/categories.dart';
import 'package:bizreh_paints_store/views/home/widgets/top_brands.dart';
import 'package:bizreh_paints_store/models/brands_featured_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeletons {
  /// Skeleton for Products Grid
  static Widget productsGrid({int count = 4}) {
    return Skeletonizer(
      enabled: true,
      child: ProductsGrid(
        products: List.generate(
          count,
          (index) => ProductModel(
            id: index,
            title: 'Loading Product Name',
            arTitle: 'اسم المنتج طويل قليلا',
            brandName: 'Loading Brand',
            arBrandName: 'ماركة التحميل',
            subCategoryName: 'Loading Category',
            arSubCategoryName: 'فئة التحميل',
            image: '',
          ),
        ),
      ),
    );
  }

  /// Skeleton for Bulletin Board Banner
  static Widget bannerCard() {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 150,
        child: BannerCard(
          banner: AdsModel(
            id: 0,
            title: 'Loading banner title text',
            arTitle: 'عنوان البانر قيد التحميل',
            description: 'Loading description',
            arDescription: 'وصف البانر',
            image: '',
          ),
        ),
      ),
    );
  }

  /// Skeleton for Top Brands
  static Widget topBrands({int count = 4}) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 110,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return BrandItem(
              item: BrandModel(
                id: 0,
                title: 'Loading',
                arTitle: 'تحميل الماركة',
                image: '',
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemCount: count,
        ),
      ),
    );
  }

  /// Skeleton for Categories List
  static Widget categories({int count = 5}) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 120,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: count,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (_, __) {
            return CategorieItem(
              item: CategoryTreeModle(
                id: 0,
                title: 'Loading',
                arTitle: 'تحميل',
                image: '',
              ),
            );
          },
        ),
      ),
    );
  }

  /// Skeleton for Collections List
  static Widget collections({int count = 4}) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 136,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: count,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, __) {
            return CollectionParentCard(
              item: CollectionModel(
                id: 0,
                title: 'Loading',
                arTitle: 'تحميل المجموعات',
                image: '',
              ),
              isSelected: false,
            );
          },
        ),
      ),
    );
  }
}
