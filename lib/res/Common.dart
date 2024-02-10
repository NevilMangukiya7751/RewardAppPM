import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/SharedPreferences/preferences.dart';

Future<List<String>> loadListFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? myList = prefs.getStringList('myListKey');
  return myList ?? []; // Return an empty list if the key is not found
}

List<String> myList = [];

Future<void> saveListToSharedPreferences(List<String> myList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('myListKey', myList);
}

/*  void addItemToList(String newItem) {
    setState(() {
      myList.add(newItem);
      // Save the updated list to SharedPreferences
      saveListToSharedPreferences(myList);
    });
  }*/

setFreeCoin(coin) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  log("Done.");
  preferences.setBool(Preferences.freeCoin, coin);
}

setCollectCoin(coin) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  log("Done.");
  preferences.setBool(Preferences.collectCoin, coin);
}

setAmount() async {
  log("setAmount....");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt(Preferences.setAmount, Preferences.totalAmount);
}

setDailyCheckIn(totalCount) async {
  log("setDailyCheckIn....");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt(Preferences.dailyCheckIn, totalCount);
}

setWatchRewardAd(totalCount) async {
  log("setWatchRewardAd....");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt(Preferences.setWatchRewardAd, totalCount);
}
