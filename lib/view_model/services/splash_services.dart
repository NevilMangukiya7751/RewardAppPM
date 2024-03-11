// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/SharedPreferences/preferences.dart';
import '../../util/routes/routes_name.dart';

class SplashServices {
  // Future<SignInModel> getUserData() => UserViewModel().getUser();
  //
  // checkAuthentication(context) async {
  //   SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  //   Preferences.tokenValue = sharedPreference.getString(Preferences.token);
  //
  //   if (Preferences.tokenValue.toString() == 'null' ||
  //       Preferences.tokenValue.toString() == '') {
  //     await Future.delayed(Duration(seconds: 3));
  //     Navigator.pushNamed(context, RoutesName.login);
  //   } else {
  //     await Future.delayed(Duration(seconds: 3));
  //     Navigator.pushNamed(context, RoutesName.homeScreen);
  //   }
  // }

  getWatchRewardAd() async {
    log("getWatchRewardAd....");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Preferences.getWatchRewardAd =
        preferences.getInt(Preferences.setWatchRewardAd)!;
    log("getWatchRewardAd....${Preferences.getWatchRewardAd}");
  }

  getAmount() async {
    log("getAmount....");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Preferences.getTotalAmount = preferences.getInt(Preferences.setAmount)!;
  }

  getDailyCheckIn() async {
    log("getDailyCheckIn....");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Preferences.getTotalDailyCheck =
        preferences.getInt(Preferences.dailyCheckIn)!;
    log("getDailyCheckIn....${Preferences.getTotalDailyCheck}");
  }

  checkAuthentication(context) async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, RoutesName.splashScreen);
    });
  }

  Future<bool> remove() async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();
    sharedPreference.clear();
    return true;
  }
}
