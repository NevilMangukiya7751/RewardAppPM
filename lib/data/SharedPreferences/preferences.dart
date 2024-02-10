class Preferences {
  Preferences._();

  static const String token = 'isToken';
  static String? tokenValue = 'isTokenValue';

  static String collectCoin = "collectCoin";
  static bool? collectedCoin;

  static String freeCoin = "freeCoin";
  static bool? freeCoins;

  static String? getWeekDay;

  static String setAmount = "setAmount";

  static String dailyCheckIn = "dailyCheckIn";
  static int getTotalDailyCheck = 0;

  static String setWatchRewardAd = "setWatchRewardAd";
  static int getWatchRewardAd = 0;

  static int totalAmount = 0;
  static int getTotalAmount = 0;

  static List<String> setStringList = [];
  static List<String> getStringList = [];
}
