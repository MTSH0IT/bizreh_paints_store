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
}
