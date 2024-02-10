// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
