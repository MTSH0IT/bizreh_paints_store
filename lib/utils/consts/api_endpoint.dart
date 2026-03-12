class ApiEndpoint {
  static const String baseUrl =
      "https://phpstack-1546924-5983780.cloudwaysapps.com";

  // Auth
  static const String login = "/user/profile/login";
  static const String signup = "/user/profile/signup";
  static const String forgetPassword = "/user/profile/forget-password";
  static const String resendVerification = "/user/profile/resend-verification";
  static const String verifyAccount = "/user/profile/verify-account";
  //user
  static const String getProfile = "/user/profile/profile";
  static const String updateProfile = "/user/profile/profile";
  static const String deleteAccount = "/user/profile/account";
  static const String changePassword = "/user/profile/change-password";
  //brands
  static const String brandsFeatured = "/user/brand/brands/featured";
  static const String brands = "/user/brand/brands";
  static String brandProducts(int id) => "/user/brand/brands/$id/products";

  //category
  static const String superCategories = "/user/category/super-categories";
  static const String categories = "/user/category/categories";
  static const String subCategories = "/user/category/sub-categories";
  static const String categoryTree = "/user/category/category-tree";
  static String superCategoryById(int id) =>
      "/user/category/super-categories/$id";
  static String categoryById(int id) => "/user/category/categories/$id";
  static String subCategoryById(int id) => "/user/category/sub-categories/$id";

  //wishlist
  static const String addWishlistItems = "/user/wishlist/items";
  static String removeWishlistItems(int id) => "/user/wishlist/items/$id";
  static const String getWishlist = "/user/wishlist/wishlist";
  static const String clearWishlist = "/user/wishlist/wishlist";

  //product
  static const String getProducts = "/user/product/products";
  static String productById(int id) => "/user/product/products/$id";
  static const topSellingProduct = "/user/product/top-selling";

  //address
  static const String createAddress = "/user/address/addresses";
  static String updateAddress(int id) => "/user/address/addresses/$id";
  static String deleteAddress(int id) => "/user/address/addresses/$id";
  static const String getAddresses = "/user/address/addresses";
  static const String getCities = "/user/address/cities";
  static String setDefaultAddress(int id) =>
      "/user/address/addresses/$id/set-default";
  static const String getDefaultAddress = "/user/address/addresses/default";

  //notifications
  static const String getNotifications = "/user/notifications/notifications";
  static const String readAllNotifications = "/user/notifications/read-all";
  static String readNotification(int id) => "/user/notifications/$id/read";
  static const String unreadCount =
      "/user/notifications/notifications/unread-count";

  //ads
  static const String getAds = "/user/ads/ads";

  //discounts
  static const String getDiscountOffers = "/user/discount";

  //points rules
  static const String getPointsRules = "/user/points";

  //points
  static const String getUserPoints = "/user/gift/points";
  static const String getPointsHistory = "/user/gift/points/history";

  //gifts
  static const String getAllGifts = "/user/gift";
  static const String getMyGifts = "/user/gift/my-gifts";
  static const String getAvailableGifts = "/user/gift/available";
  static const String redeemGift = "/user/gift/redeem";

  //cart
  static const String addToCart = "/user/cart/add";
  static const String getCart = "/user/cart";
  static String updateCart(int id) => "/user/cart/$id";
  static String deleteCart(int id) => "/user/cart/$id";
  static String increaseCart(int id) => "/user/cart/$id/increase";
  static String decreaseCart(int id) => "/user/cart/$id/decrease";

  //order
  static const String createOrder = "/user/order";
  static const String getOrder = "/user/order";
  static String detailsOrder(int id) => "/user/order/$id";
  static String pendOrder(int id) => "/user/order/$id/pend";
  static String cancelOrder(int id) => "/user/order/$id/cancel";
  static String reorder(int id) => "/user/order/$id/reorder";
  static String complaint(int id) => "/user/order/$id/complaint";
}
