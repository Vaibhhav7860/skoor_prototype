/// App Constants
class AppConstants {
  AppConstants._();
  
  // App Info
  static const String appName = 'Skoor';
  static const String appTagline = 'Predict & Win';
  static const String appVersion = '1.0.0';
  
  // Currency
  static const String currencyName = 'Scholar';
  static const String currencySymbol = '§';
  static const int initialBonus = 5;
  static const int minPredictionStake = 5;
  
  // API Endpoints (Mock for prototype)
  static const String baseUrl = 'https://api.skoor.app';
  
  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 3);
  
  // Padding & Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;
  
  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusRound = 50.0;
  
  // Icon Sizes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  
  // Card Elevation
  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
}

/// Asset Paths
class AppAssets {
  AppAssets._();
  
  // Images
  static const String imagesPath = 'assets/images/';
  static const String logo = '${imagesPath}logo.png';
  static const String logoLight = '${imagesPath}logo_light.png';
  static const String stadium = '${imagesPath}stadium.png';
  static const String footballField = '${imagesPath}field.png';
  static const String defaultAvatar = '${imagesPath}avatar.png';
  static const String defaultTeamLogo = '${imagesPath}team_default.png';
  
  // Onboarding
  static const String onboarding1 = '${imagesPath}onboarding_1.png';
  static const String onboarding2 = '${imagesPath}onboarding_2.png';
  static const String onboarding3 = '${imagesPath}onboarding_3.png';
  
  // Icons
  static const String iconsPath = 'assets/icons/';
  static const String scholarCoin = '${iconsPath}scholar_coin.svg';
  static const String football = '${iconsPath}football.svg';
  static const String trophy = '${iconsPath}trophy.svg';
  static const String wallet = '${iconsPath}wallet.svg';
  static const String store = '${iconsPath}store.svg';
}

/// Route Names
class AppRoutes {
  AppRoutes._();
  
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String main = '/main';
  static const String home = '/home';
  static const String matches = '/matches';
  static const String matchDetail = '/match-detail';
  static const String predictions = '/predictions';
  static const String news = '/news';
  static const String newsDetail = '/news-detail';
  static const String wallet = '/wallet';
  static const String buyScholars = '/buy-scholars';
  static const String store = '/store';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
}
