class ApiEndpoint {
  static const String baseUrl =
      "https://phpstack-1546924-5983780.cloudwaysapps.com";

  // Auth
  static const String login = "/user/profile/login";
  static const String signup = "/user/profile/signup";
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
}
