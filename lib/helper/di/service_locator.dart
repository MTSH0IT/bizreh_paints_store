import 'package:get_it/get_it.dart';
import 'package:bizreh_paints_store/helper/dioApiService/dio_client.dart';
import 'package:bizreh_paints_store/helper/dioApiService/i_api_client.dart';
import 'package:bizreh_paints_store/helper/dioApiService/dio_client_adapter.dart';
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
import 'package:bizreh_paints_store/services/version_service.dart';
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
  _initVersionServices();
  _initAdsServices();
}

void _initCoreServices() {
  // DioClient - HTTP client singleton
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<IApiClient>(() => DioClientAdapter(sl<DioClient>()));

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
    () => AuthService(apiClient: sl<IApiClient>()),
  );
}

void _initAddressServices() {
  sl.registerLazySingleton<AddressServices>(
    () => AddressServices(apiClient: sl<IApiClient>()),
  );
}

void _initCartServices() {
  sl.registerLazySingleton<CartServices>(
    () => CartServices(apiClient: sl<IApiClient>()),
  );
}

void _initProductServices() {
  sl.registerLazySingleton<ProductServices>(
    () => ProductServices(apiClient: sl<IApiClient>()),
  );
}

void _initWishlistServices() {
  sl.registerLazySingleton<WishListServices>(
    () => WishListServices(apiClient: sl<IApiClient>()),
  );
}

void _initOrderServices() {
  sl.registerLazySingleton<OrderServices>(
    () => OrderServices(apiClient: sl<IApiClient>()),
  );
}

void _initUserServices() {
  sl.registerLazySingleton<UserService>(
    () => UserService(apiClient: sl<IApiClient>()),
  );
}

void _initBrandServices() {
  sl.registerLazySingleton<BrandsServices>(
    () => BrandsServices(apiClient: sl<IApiClient>()),
  );
}

void _initCategoryServices() {
  sl.registerLazySingleton<CategoryServices>(
    () => CategoryServices(apiClient: sl<IApiClient>()),
  );
}

void _initCollectionServices() {
  sl.registerLazySingleton<CollectionServices>(
    () => CollectionServices(apiClient: sl<IApiClient>()),
  );
}

void _initFilterServices() {
  sl.registerLazySingleton<FilterServices>(
    () => FilterServices(apiClient: sl<IApiClient>()),
  );
}

void _initGiftsServices() {
  sl.registerLazySingleton<GiftsService>(
    () => GiftsService(apiClient: sl<IApiClient>()),
  );
}

void _initNotificationsServices() {
  sl.registerLazySingleton<NotificationsServices>(
    () => NotificationsServices(apiClient: sl<IApiClient>()),
  );
}

void _initOffersCartServices() {
  sl.registerLazySingleton<OffersCartService>(
    () => OffersCartService(apiClient: sl<IApiClient>()),
  );
}

void _initPaymentsServices() {
  sl.registerLazySingleton<PaymentsServices>(
    () => PaymentsServices(apiClient: sl<IApiClient>()),
  );
}

void _initPointsServices() {
  sl.registerLazySingleton<PointsServices>(
    () => PointsServices(apiClient: sl<IApiClient>()),
  );
}

void _initRewardsServices() {
  sl.registerLazySingleton<RewardsServices>(
    () => RewardsServices(apiClient: sl<IApiClient>()),
  );
}

void _initAdsServices() {
  sl.registerLazySingleton<AdsServices>(
    () => AdsServices(apiClient: sl<IApiClient>()),
  );
}

void _initVersionServices() {
  sl.registerLazySingleton<VersionService>(
    () => VersionService(apiClient: sl<IApiClient>()),
  );
}
