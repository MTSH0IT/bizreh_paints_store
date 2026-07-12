import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'package:bizreh_paints_store/controllers/auth_controller.dart';
import 'package:bizreh_paints_store/controllers/cart_controllers.dart';
import 'package:bizreh_paints_store/controllers/collection_controllers.dart';
import 'package:bizreh_paints_store/controllers/filter_controller.dart';
import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/controllers/main_view_controller.dart';
import 'package:bizreh_paints_store/controllers/notifications_controllers.dart';
import 'package:bizreh_paints_store/controllers/offers_cart_controller.dart';
import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/controllers/payments_controller.dart';
import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/controllers/points_controller.dart';
import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/controllers/rewards_controller.dart';
import 'package:bizreh_paints_store/controllers/version_controller.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/helper/di/service_locator.dart';
import 'package:bizreh_paints_store/helper/di/token_provider.dart';
import 'package:bizreh_paints_store/services/address_services.dart';
import 'package:bizreh_paints_store/services/ads_services.dart';
import 'package:bizreh_paints_store/services/auth_services.dart';
import 'package:bizreh_paints_store/services/brands_services.dart';
import 'package:bizreh_paints_store/services/cart_services.dart';
import 'package:bizreh_paints_store/services/category_services.dart';
import 'package:bizreh_paints_store/services/collection_services.dart';
import 'package:bizreh_paints_store/services/filter_services.dart';
import 'package:bizreh_paints_store/services/gifts_service.dart';
import 'package:bizreh_paints_store/services/notifications_services.dart';
import 'package:bizreh_paints_store/services/offers_cart_service.dart';
import 'package:bizreh_paints_store/services/order_services.dart';
import 'package:bizreh_paints_store/services/payments_services.dart';
import 'package:bizreh_paints_store/services/points_services.dart';
import 'package:bizreh_paints_store/services/product_services.dart';
import 'package:bizreh_paints_store/services/rewards_services.dart';
import 'package:bizreh_paints_store/services/user_services.dart';
import 'package:bizreh_paints_store/services/version_service.dart';
import 'package:bizreh_paints_store/services/wishList_services.dart';
import 'package:bizreh_paints_store/utils/storageService/storage_service.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VersionController>(
      () => VersionController(versionService: sl<VersionService>()),
      fenix: true,
    );

    Get.lazyPut<AuthController>(
      () => AuthController(
        authService: sl<AuthService>(),
        storageService: sl<StorageService>(),
        tokenProvider: sl<ITokenProvider>(),
      ),
      fenix: true,
    );

    Get.lazyPut<AddressController>(
      () => AddressController(addressServices: sl<AddressServices>()),
      fenix: true,
    );

    Get.lazyPut<CartController>(
      () => CartController(cartServices: sl<CartServices>()),
      fenix: true,
    );

    Get.lazyPut<ProductDetailsController>(
      () =>
          ProductDetailsController(cartController: Get.find<CartController>()),
      fenix: true,
    );

    Get.lazyPut<WishListController>(
      () => WishListController(wishListServices: sl<WishListServices>()),
      fenix: true,
    );

    Get.lazyPut<OrderController>(
      () => OrderController(
        orderServices: sl<OrderServices>(),
        cartController: Get.find<CartController>(),
      ),
      fenix: true,
    );

    Get.lazyPut<PersonalController>(
      () => PersonalController(
        userService: sl<UserService>(),
        storageService: sl<StorageService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        brandsServices: sl<BrandsServices>(),
        categoryServices: sl<CategoryServices>(),
        productServices: sl<ProductServices>(),
        adsServices: sl<AdsServices>(),
      ),
      fenix: true,
    );

    Get.lazyPut<FilterController>(
      () => FilterController(
        brandsServices: sl<BrandsServices>(),
        categoryServices: sl<CategoryServices>(),
        filterServices: sl<FilterServices>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GiftsController>(
      () => GiftsController(giftsServices: sl<GiftsService>()),
      fenix: true,
    );

    Get.lazyPut<NotificationsControllers>(
      () => NotificationsControllers(
        notificationsServices: sl<NotificationsServices>(),
      ),
      fenix: true,
    );

    Get.lazyPut<OffersCartController>(
      () => OffersCartController(offersCartService: sl<OffersCartService>()),
      fenix: true,
    );

    Get.lazyPut<PaymentsController>(
      () => PaymentsController(paymentsServices: sl<PaymentsServices>()),
      fenix: true,
    );

    Get.lazyPut<PointsController>(
      () => PointsController(pointsServices: sl<PointsServices>()),
      fenix: true,
    );

    Get.lazyPut<RewardsController>(
      () => RewardsController(
        rewardsServices: sl<RewardsServices>(),
        productServices: sl<ProductServices>(),
      ),
      fenix: true,
    );

    Get.lazyPut<CollectionControllers>(
      () => CollectionControllers(collectionServices: sl<CollectionServices>()),
      fenix: true,
    );

    Get.lazyPut<MainViewController>(() => MainViewController(), fenix: true);
  }
}
