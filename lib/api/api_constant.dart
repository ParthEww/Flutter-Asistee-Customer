abstract class ApiConstant {
  static const String appName = "App name";
  static const String deviceType = "passenger_android";

  static String baseUrl = "https://dev.fhd-tech.com/api/passenger/";
  static const String init = "init/";
  static const String login = "auth/login";

  static String lang = "en";
  static String key = "Gobus@123*";

  /// Firebase Token
  static String firebaseToken = "";

  // Success status code range
  static const API_SUCCESS_RANGE = [200, 201, 202];
  static const API_NO_INTERNET_EXCEPTION = 503;
  static const API_AUTH_EXCEPTION = 401;
  static const API_CUSTOM_EXCEPTION = 400;
  static const API_MAINTENANCE_MODE_EXCEPTION = 503;
}

abstract class Constants {
  static const mapApiBaseUrl = ''; // todo: verify before production
  static const iosAppStoreId = ''; // todo: verify before production
  static const googleMapKey = ''; // todo: verify before production
}
