import 'package:get_it/get_it.dart';
import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/utils/storageService/storage_service.dart';
import 'package:bizreh_paints_store/services/auth_services.dart';
import 'package:bizreh_paints_store/services/address_services.dart';
import 'package:bizreh_paints_store/services/cart_services.dart';
import 'package:bizreh_paints_store/services/product_services.dart';
import 'package:bizreh_paints_store/services/wishList_services.dart';
import 'package:bizreh_paints_store/services/order_services.dart';
import 'package:bizreh_paints_store/services/user_services.dart';
import 'package:bizreh_paints_store/services/brands_services.dart';
import 'package:bizreh_paints_store/services/category_services.dart';
import 'package:bizreh_paints_store/services/collection_services.dart';
import 'package:bizreh_paints_store/services/filter_services.dart';
import 'package:bizreh_paints_store/services/gifts_service.dart';
import 'package:bizreh_paints_store/services/notifications_services.dart';
import 'package:bizreh_paints_store/services/offers_cart_service.dart';
import 'package:bizreh_paints_store/services/payments_services.dart';
import 'package:bizreh_paints_store/services/points_services.dart';
import 'package:bizreh_paints_store/services/rewards_services.dart';
import 'package:bizreh_paints_store/services/ads_services.dart';
import 'package:bizreh_paints_store/helper/di/token_provider.dart';

/// Service Locator using GetIt for dependency injection
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> init() async {
  // Core Services
  _initCoreServices();

  // Feature Services
  _initAuthServices();
  _initAddressServices();
  _initCartServices();
  _initProductServices();
  _initWishlistServices();
  _initOrderServices();
  _initUserServices();
  _initBrandServices();
  _initCategoryServices();
  _initCollectionServices();
  _initFilterServices();
  _initGiftsServices();
  _initNotificationsServices();
  _initOffersCartServices();
  _initPaymentsServices();
  _initPointsServices();
  _initRewardsServices();
  _initAdsServices();
}

void _initCoreServices() {
  // DioClient - HTTP client singleton
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // StorageService - Local storage singleton
  // Note: This assumes StorageService.init() is called before this registration
  sl.registerLazySingleton<StorageService>(() => StorageService());

  // TokenProvider - Token management
  sl.registerLazySingleton<ITokenProvider>(
    () => TokenProvider(storageService: sl<StorageService>()),
  );
}

void _initAuthServices() {
  sl.registerLazySingleton<AuthService>(
    () => AuthService(dioClient: sl<DioClient>()),
  );
}

void _initAddressServices() {
  sl.registerLazySingleton<AddressServices>(
    () => AddressServices(dioClient: sl<DioClient>()),
  );
}

void _initCartServices() {
  sl.registerLazySingleton<CartServices>(
    () => CartServices(dioClient: sl<DioClient>()),
  );
}

void _initProductServices() {
  sl.registerLazySingleton<ProductServices>(
    () => ProductServices(dioClient: sl<DioClient>()),
  );
}

void _initWishlistServices() {
  sl.registerLazySingleton<WishListServices>(
    () => WishListServices(dioClient: sl<DioClient>()),
  );
}

void _initOrderServices() {
  sl.registerLazySingleton<OrderServices>(
    () => OrderServices(dioClient: sl<DioClient>()),
  );
}

void _initUserServices() {
  sl.registerLazySingleton<UserService>(
    () => UserService(dioClient: sl<DioClient>()),
  );
}

void _initBrandServices() {
  sl.registerLazySingleton<BrandsServices>(
    () => BrandsServices(dioClient: sl<DioClient>()),
  );
}

void _initCategoryServices() {
  sl.registerLazySingleton<CategoryServices>(
    () => CategoryServices(dioClient: sl<DioClient>()),
  );
}

void _initCollectionServices() {
  sl.registerLazySingleton<CollectionServices>(
    () => CollectionServices(dioClient: sl<DioClient>()),
  );
}

void _initFilterServices() {
  sl.registerLazySingleton<FilterServices>(
    () => FilterServices(dioClient: sl<DioClient>()),
  );
}

void _initGiftsServices() {
  sl.registerLazySingleton<GiftsService>(
    () => GiftsService(dioClient: sl<DioClient>()),
  );
}

void _initNotificationsServices() {
  sl.registerLazySingleton<NotificationsServices>(
    () => NotificationsServices(dioClient: sl<DioClient>()),
  );
}

void _initOffersCartServices() {
  sl.registerLazySingleton<OffersCartService>(
    () => OffersCartService(dioClient: sl<DioClient>()),
  );
}

void _initPaymentsServices() {
  sl.registerLazySingleton<PaymentsServices>(
    () => PaymentsServices(dioClient: sl<DioClient>()),
  );
}

void _initPointsServices() {
  sl.registerLazySingleton<PointsServices>(
    () => PointsServices(dioClient: sl<DioClient>()),
  );
}

void _initRewardsServices() {
  sl.registerLazySingleton<RewardsServices>(
    () => RewardsServices(dioClient: sl<DioClient>()),
  );
}

void _initAdsServices() {
  sl.registerLazySingleton<AdsServices>(
    () => AdsServices(dioClient: sl<DioClient>()),
  );
}
