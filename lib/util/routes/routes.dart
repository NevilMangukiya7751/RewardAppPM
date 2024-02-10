// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reward_app/util/routes/routes_name.dart';
import 'package:reward_app/view/AboutUsScreen.dart';
import 'package:reward_app/view/GiftScreens/GiftScreen.dart';
import 'package:reward_app/view/LanguageScreens/ChooseLanguageScreen.dart';
import 'package:reward_app/view/LoginScreens/LoginScreen.dart';
import 'package:reward_app/view/RewardScreens/RewardScreen.dart';
import 'package:reward_app/view/SettingScreens.dart';
import 'package:reward_app/view/WalletScreens/walletScreen.dart';

import '../../view/GenderScreen/GenderScreen.dart';
import '../../view/SplashScreen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());
      case RoutesName.chooseLaunguageScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ChooseLanguageScreen());
      case RoutesName.genderScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => GenderScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
      case RoutesName.rewardScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => RewardScreen());
      case RoutesName.walletScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => WalletScreen());
      case RoutesName.giftScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => GiftScreen());
      case RoutesName.settingScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SettingScreen());
      case RoutesName.aboutUsScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => AboutUsScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("No route Defined"),
            ),
          );
        });
    }
  }
}
