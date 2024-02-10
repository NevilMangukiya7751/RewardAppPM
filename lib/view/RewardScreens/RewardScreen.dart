// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reward_app/data/SharedPreferences/preferences.dart';
import 'package:reward_app/res/Common.dart';
import 'package:reward_app/util/images/imageConstant.dart';
import 'package:reward_app/util/routes/routes_name.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  int currentDay = 1;
  int totalDays = 7;
  int collectedCoins = 0;

  bool freecoin = false;

  bool loading = false;

  int tapCount = 0;

  int watchTotalCount = 0;

  @override
  void initState() {
    super.initState();
    getFreeCoin();
    getDailyCheckIn();
    checkIfCanCollect();
    getCollectedCoin();
    getWatchRewardAd();
    nextDeadline = getNextDeadline(date);
    deadLine();
    loadListFromSharedPreferences().then((loadedList) {
      setState(() {
        myList = loadedList;
      });
    });
  }

  bool canCollect = true;

  void addItemToList(String newItem) {
    if (!myList.contains(newItem)) {
      setState(() {
        myList.add(newItem);
        saveListToSharedPreferences(myList);
      });
    } else {
      log('Item already exists in the list: $newItem');
    }
  }

  final date = DateTime.now();
  var nextDeadline;
  Future<void> checkIfCanCollect() async {
    canCollect = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastCollectionTimeString =
        prefs.getString('last_collection_time') ?? '';

    if (lastCollectionTimeString.isNotEmpty) {
      DateTime lastCollectionTime = DateTime.parse(lastCollectionTimeString);

      // Get the end of the day for the lastCollectionTime
      DateTime endOfDayLastCollectionTime = DateTime(
        lastCollectionTime.year,
        lastCollectionTime.month,
        lastCollectionTime.day,
        23,
        59,
        59,
      );

      DateTime now = DateTime.now();

      // Check if the current time is after 12 PM (noon) of the same day as lastCollectionTime
      if (now.isAfter(endOfDayLastCollectionTime.add(Duration(hours: 12)))) {
        canCollect = true;
      }
    } else {
      // If 'last_collection_time' is not set, you can consider it as the first collection
      canCollect = true;
    }

    if (canCollect) {
      // Perform the actions for collecting
      // For example:
      // collect();
      print('You can collect now.');
    } else {
      print('You cannot collect yet.');
    }
  }

  deadLine() {
    nextDeadline = getNextDeadline(date);

    if (nextDeadline.day == date.day) {
      setState(() {
        Preferences.freeCoins = false;
      });
    } else {
      print("Next deadline is tomorrow!");
    }
  }

  DateTime getNextDeadline(DateTime now) {
    final todaysDeadline = DateTime(now.year, now.month, now.day);

    if (now.isBefore(todaysDeadline)) {
      return todaysDeadline;
    }

    return todaysDeadline.add(Duration(days: 1));
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

  getWatchRewardAd() async {
    log("getWatchRewardAd....");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Preferences.getWatchRewardAd =
        preferences.getInt(Preferences.setWatchRewardAd)!;
    log("getWatchRewardAd....${Preferences.getWatchRewardAd}");
  }

  getFreeCoin() async {
    log("getFreeCoin....");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Preferences.freeCoins = preferences.getBool(Preferences.freeCoin);
    });
    /*if (Preferences.freeCoins == true) {
      log("if ${Preferences.freeCoins}");
      Timer.periodic(Duration(minutes: 2), (timer) {
        log("timer $timer");
        setState(() {
          Preferences.freeCoins = false;
        });
      });
    } else {
      log("else ${Preferences.freeCoins}");
      // Timer.periodic(Duration(seconds: 30), (timer) {
      //   setState(() {
      //     Preferences.freeCoins = false;
      //   });
      // });
    }*/
    log("Done. ${Preferences.freeCoins}");
  }

  getCollectedCoin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Preferences.collectedCoin = preferences.getBool(Preferences.collectCoin);
    });
    if (Preferences.collectedCoin == true) {
      log("if collectedCoin ${Preferences.collectedCoin}");
      Timer.periodic(Duration(minutes: 1440), (timer) {
        setState(() {
          Preferences.collectedCoin = false;
        });
      });
    } else {
      log("else collectedCoin ${Preferences.collectedCoin}");
      // Timer.periodic(Duration(seconds: 30), (timer) {
      //   setState(() {
      //     Preferences.freeCoins = false;
      //   });
      // });
    }

    log("Done. ${Preferences.collectedCoin}");
  }

  @override
  Widget build(BuildContext context) {
    print("nextDeadline ${nextDeadline.day}");

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    log("getStringList ${Preferences.getStringList}");
    log("freeCoins ${Preferences.freeCoins}");

    getAmount();
    saveListToSharedPreferences(myList);

    loadListFromSharedPreferences().then((loadedList) {
      log('Loaded List: $loadedList');
    });

    return Scaffold(
        backgroundColor: Color(0xfff7f7f7),
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: height / 4,
                    width: width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ImageConstant.bg),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Image.asset(
                                ImageConstant.setting,
                                scale: 5,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.settingScreen);
                              },
                            ),
                            Text(
                              'RewardZone',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.giftScreen);
                              },
                              child: Image.asset(
                                ImageConstant.gift,
                                scale: 4,
                              ),
                            )
                          ],
                        ),
                        Gap(20),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              ImageConstant.coin,
                              scale: 5,
                            ),
                            Gap(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Balance',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  Preferences.getTotalAmount.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.walletScreen);
                              },
                              child: Image.asset(
                                ImageConstant.wallet,
                                scale: 4,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 20, top: 20),
                          // height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: width * 0.88,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Check-in 7 Days To Win 220 coins',
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                  height: 60,
                                  child: ListView.separated(
                                    itemCount: daysList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      bool isCollected =
                                          myList.contains("${i + 1}");

                                      log("isccc $isCollected ${i.toString()}");
                                      return Column(
                                        children: [
                                          (isCollected != true)
                                              ? Image.asset(
                                                  daysList[i]['image'],
                                                  scale: 4,
                                                )
                                              : Image.asset(
                                                  daysList[i]['collectImage'],
                                                  scale: 4,
                                                ),
                                          SizedBox(height: 5),
                                          (isCollected != true)
                                              ? Text(
                                                  daysList[i]['days'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF808080),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              : Image.asset(
                                                  ImageConstant.done,
                                                  scale: 4,
                                                ),
                                        ],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(width: 7);
                                    },
                                  )),
                              Gap(20),
                              Center(
                                child: (Preferences.collectedCoin == true)
                                    ? Container(
                                        alignment: Alignment.center,
                                        width: width * 0.7,
                                        height: 37,
                                        decoration: ShapeDecoration(
                                          color: Color(0xffD0D0D0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(120),
                                          ),
                                        ),
                                        child: Text(
                                          'COLLECT COIN',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          // collectCoins();
                                          String weekday = DateTime.now()
                                              .toUtc()
                                              .weekday
                                              .toString();
                                          log("Wwee $weekday");

                                          int value = 5;

                                          if (weekday == "1") {
                                            setState(() {
                                              value = 5;
                                            });
                                          } else if (weekday == "2") {
                                            setState(() {
                                              value = 10;
                                            });
                                          } else if (weekday == "3") {
                                            setState(() {
                                              value = 15;
                                            });
                                          } else if (weekday == "4") {
                                            setState(() {
                                              value = 20;
                                            });
                                          } else if (weekday == "5") {
                                            setState(() {
                                              value = 30;
                                            });
                                          } else if (weekday == "6") {
                                            setState(() {
                                              value = 35;
                                            });
                                          } else if (weekday == "7") {
                                            setState(() {
                                              value = 60;
                                            });
                                          }

                                          log("value = $value");
                                          addItemToList(weekday);
                                          setState(() {
                                            setCollectCoin(true);
                                            Preferences.totalAmount =
                                                Preferences.getTotalAmount +
                                                    value;
                                            // Preferences.totalAmount += 10;
                                            setAmount();
                                          });
                                          getAmount();
                                          getCollectedCoin();
                                          if (Preferences.collectedCoin ==
                                              true) {
                                            log("if collectedCoin ${Preferences.collectedCoin}");
                                            Timer.periodic(
                                                Duration(minutes: 1440),
                                                (timer) {
                                              setState(() {
                                                Preferences.collectedCoin =
                                                    false;
                                              });
                                            });
                                          } else {
                                            log("else collectedCoin ${Preferences.collectedCoin}");
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: width * 0.7,
                                          height: 37,
                                          decoration: ShapeDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFFD6C25),
                                                Color(0xFFFF4D1C),
                                                Color(0xFFFC4010),
                                                Color(0xFFFA6401),
                                                Color(0xFFFF7623),
                                                Color(0xFFFF7623),
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(120),
                                            ),
                                          ),
                                          child: Text(
                                            'COLLECT COIN',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 350, right: 20, left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(ImageConstant.coin, scale: 8),
                            Gap(5),
                            Text(
                              'Take part in the following activities to earn coins',
                              style: TextStyle(
                                color: Color(0xFF808080),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        Container(
                          width: width,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Free Coin',
                                        style: TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        (Preferences.freeCoins == true)
                                            ? 'Complete 1/1'
                                            : 'Complete 0/1',
                                        style: TextStyle(
                                          color: Color(0xFF787878),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  (Preferences.freeCoins == true)
                                      ? GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: width / 3.5,
                                            height: height / 22,
                                            decoration: ShapeDecoration(
                                              color: Color(0xffD0D0D0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(140),
                                              ),
                                            ),
                                            child: Text(
                                              'Done',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              setFreeCoin(true);
                                              Preferences.totalAmount =
                                                  Preferences.getTotalAmount +
                                                      10;
                                              // Preferences.totalAmount += 10;
                                              setAmount();
                                            });
                                            getFreeCoin();
                                            getAmount();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: width / 3.5,
                                            height: height / 22,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                // center: Alignment(1.04, 0.59),
                                                // radius: 0.57,
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xFFFD6C25),
                                                  Color(0xFFFF4D1C),
                                                  Color(0xFFFC4010),
                                                  Color(0xFFFA6401),
                                                  Color(0xFFFF7623),
                                                  Color(0xFFFF7623),
                                                ],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(140),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      ImageConstant.coin),
                                                  height: 24,
                                                ),
                                                Gap(5),
                                                Text(
                                                  'Get 10',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                ],
                              ),
                              Gap(20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Daily Check-In',
                                        style: TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Complete ${Preferences.getTotalDailyCheck}/3',
                                        style: TextStyle(
                                          color: Color(0xFF787878),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  (Preferences.getTotalDailyCheck == 3)
                                      ? GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: width / 3.5,
                                            height: height / 22,
                                            decoration: ShapeDecoration(
                                              color: Color(0xffD0D0D0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(140),
                                              ),
                                            ),
                                            child: Text(
                                              'Done',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            if (tapCount < 3) {
                                              // Respond to tap (you can replace this with your own logic)
                                              print(
                                                  'Button tapped ${tapCount + 1} time(s)');
                                              setDailyCheckIn(tapCount + 1);
                                              setState(() {
                                                tapCount++;
                                              });
                                              setState(() {
                                                Preferences.totalAmount =
                                                    Preferences.getTotalAmount +
                                                        15;
                                                setAmount();
                                              });
                                              getFreeCoin();
                                              getAmount();
                                              getDailyCheckIn();
                                              if (Preferences
                                                      .getTotalDailyCheck ==
                                                  3) {
                                                log("if getTotalDailyCheck ${Preferences.getTotalDailyCheck}");
                                                Timer.periodic(
                                                    Duration(days: 1), (timer) {
                                                  setState(() {
                                                    Preferences
                                                        .getTotalDailyCheck = 0;
                                                  });
                                                });
                                              } else {
                                                log("else getTotalDailyCheck ${Preferences.freeCoins}");
                                                // Timer.periodic(Duration(seconds: 30), (timer) {
                                                //   setState(() {
                                                //     Preferences.freeCoins = false;
                                                //   });
                                                // });
                                              }
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: width / 3.5,
                                            height: height / 22,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                // center: Alignment(1.04, 0.59),
                                                // radius: 0.57,
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xFFFD6C25),
                                                  Color(0xFFFF4D1C),
                                                  Color(0xFFFC4010),
                                                  Color(0xFFFA6401),
                                                  Color(0xFFFF7623),
                                                  Color(0xFFFF7623),
                                                ],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(140),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      ImageConstant.coin),
                                                  height: 24,
                                                ),
                                                Gap(5),
                                                Text(
                                                  'Get 15',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              Gap(20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Watch Reward Ad',
                                        style: TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Complete ${Preferences.getWatchRewardAd}/2',
                                        style: TextStyle(
                                          color: Color(0xFF787878),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  (Preferences.getWatchRewardAd == 2)
                                      ? GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: width / 3.5,
                                            height: height / 22,
                                            decoration: ShapeDecoration(
                                              color: Color(0xffD0D0D0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(140),
                                              ),
                                            ),
                                            child: Text(
                                              'Done',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            if (watchTotalCount < 2) {
                                              // Respond to tap (you can replace this with your own logic)
                                              print(
                                                  'Button tapped ${watchTotalCount + 1} time(s)');
                                              setWatchRewardAd(
                                                  watchTotalCount + 1);
                                              setState(() {
                                                watchTotalCount++;
                                              });
                                              setState(() {
                                                Preferences.totalAmount =
                                                    Preferences.getTotalAmount +
                                                        20;
                                                setAmount();
                                              });
                                              getFreeCoin();
                                              getAmount();
                                              getWatchRewardAd();
                                              if (Preferences
                                                      .getWatchRewardAd ==
                                                  2) {
                                                log("if getWatchRewardAd ${Preferences.getWatchRewardAd}");
                                                Timer.periodic(
                                                    Duration(days: 1), (timer) {
                                                  setState(() {
                                                    Preferences
                                                        .getWatchRewardAd = 0;
                                                  });
                                                });
                                              } else {
                                                log("else getWatchRewardAd ${Preferences.getWatchRewardAd}");
                                                // Timer.periodic(Duration(seconds: 30), (timer) {
                                                //   setState(() {
                                                //     Preferences.freeCoins = false;
                                                //   });
                                                // });
                                              }
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: width / 3.5,
                                            height: height / 22,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                // center: Alignment(1.04, 0.59),
                                                // radius: 0.57,
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xFFFD6C25),
                                                  Color(0xFFFF4D1C),
                                                  Color(0xFFFC4010),
                                                  Color(0xFFFA6401),
                                                  Color(0xFFFF7623),
                                                  Color(0xFFFF7623),
                                                ],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(140),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      ImageConstant.coin),
                                                  height: 24,
                                                ),
                                                Gap(5),
                                                Text(
                                                  'Get 20',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              Gap(20),
                              Row(
                                children: [
                                  Text(
                                    'Play Quiz & Win Now',
                                    style: TextStyle(
                                      color: Color(0xFF1E1E1E),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Preferences.totalAmount =
                                            Preferences.getTotalAmount + 20;
                                        setAmount();
                                      });
                                      getAmount();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: width / 3.5,
                                      height: height / 22,
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          // center: Alignment(1.04, 0.59),
                                          // radius: 0.57,
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFFFD6C25),
                                            Color(0xFFFF4D1C),
                                            Color(0xFFFC4010),
                                            Color(0xFFFA6401),
                                            Color(0xFFFF7623),
                                            Color(0xFFFF7623),
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(140),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image:
                                                AssetImage(ImageConstant.coin),
                                            height: 24,
                                          ),
                                          Gap(5),
                                          Text(
                                            'Get 20',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gap(20),
                        Container(
                          width: width,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset(ImageConstant.invite),
                              Gap(10),
                              Text(
                                'Invite your friends',
                                style: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Share.share(
                                          'check out my website https://example.com',
                                          subject: 'Look what I made!')
                                      .then((value) {
                                    setState(() {
                                      Preferences.totalAmount =
                                          Preferences.getTotalAmount + 20;
                                      setAmount();
                                    });
                                    getAmount();
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width / 3.5,
                                  height: height / 22,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      // center: Alignment(1.04, 0.59),
                                      // radius: 0.57,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFD6C25),
                                        Color(0xFFFF4D1C),
                                        Color(0xFFFC4010),
                                        Color(0xFFFA6401),
                                        Color(0xFFFF7623),
                                        Color(0xFFFF7623),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(140),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(ImageConstant.coin),
                                        height: 24,
                                      ),
                                      Gap(5),
                                      Text(
                                        'Get 20',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  List daysList = [
    {
      'image': ImageConstant.coin5,
      'days': 'Day 1',
      'collectImage': ImageConstant.collectedCoin5
    },
    {
      'image': ImageConstant.coin10,
      'days': 'Day 2',
      'collectImage': ImageConstant.collectedCoin10
    },
    {
      'image': ImageConstant.coin15,
      'days': 'Day 3',
      'collectImage': ImageConstant.collectedCoin15
    },
    {
      'image': ImageConstant.coin20,
      'days': 'Day 4',
      'collectImage': ImageConstant.collectedCoin20
    },
    {
      'image': ImageConstant.coin30,
      'days': 'Day 5',
      'collectImage': ImageConstant.collectedCoin30
    },
    {
      'image': ImageConstant.coin35,
      'days': 'Day 6',
      'collectImage': ImageConstant.collectedCoin35
    },
    {
      'image': ImageConstant.coin60,
      'days': 'Day 7',
      'collectImage': ImageConstant.collectedCoin60
    },
  ];
}

/*
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reward_app/util/images/imageConstant.dart';
import 'package:reward_app/util/routes/routes_name.dart';

import '../../res/Dailog/congratulationDialog.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  int currentDay = 1;
  int totalDays = 7;
  int collectedCoins = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height / 4,
                  width: width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(ImageConstant.bg),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Image.asset(
                              ImageConstant.setting,
                              scale: 5,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.settingScreen);
                            },
                          ),
                          Text(
                            'RewardZone',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.giftScreen);
                            },
                            child: Image.asset(
                              ImageConstant.gift,
                              scale: 4,
                            ),
                          )
                        ],
                      ),
                      Gap(20),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            ImageConstant.coin,
                            scale: 5,
                          ),
                          Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Balance',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              Text(
                                '500',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.walletScreen);
                            },
                            child: Image.asset(
                              ImageConstant.wallet,
                              scale: 4,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 20, top: 20),
                        // height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: width * 0.88,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Check-in 7 Days To Win 220 coins',
                              style: TextStyle(
                                color: Color(0xFF808080),
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      ImageConstant.coin5,
                                      scale: 4,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Day 1',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      ImageConstant.coin10,
                                      scale: 4,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Day 2',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      ImageConstant.coin15,
                                      scale: 4,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Day 3',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      ImageConstant.coin20,
                                      scale: 4,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Day 4',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      ImageConstant.coin30,
                                      scale: 4,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Day 5',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      ImageConstant.coin35,
                                      scale: 4,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Day 6  ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      ImageConstant.coin60,
                                      scale: 4,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Day 7',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Gap(20),
                            Center(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.7,
                                  height: 37,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFD6C25),
                                        Color(0xFFFF4D1C),
                                        Color(0xFFFC4010),
                                        Color(0xFFFA6401),
                                        Color(0xFFFF7623),
                                        Color(0xFFFF7623),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(120),
                                    ),
                                  ),
                                  child: Text(
                                    'COLLECT COIN',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 350, right: 20, left: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(ImageConstant.coin, scale: 8),
                          Gap(5),
                          Text(
                            'Take part in the following activities to earn coins',
                            style: TextStyle(
                              color: Color(0xFF808080),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Gap(20),
                      Container(
                        width: width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Free Coin',
                                      style: TextStyle(
                                        color: Color(0xFF1E1E1E),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Complete 0/1',
                                      style: TextStyle(
                                        color: Color(0xFF787878),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    // congratulationDialog(context);
                                    congratulationDialog2(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: width / 3.5,
                                    height: height / 22,
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        // center: Alignment(1.04, 0.59),
                                        // radius: 0.57,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFFD6C25),
                                          Color(0xFFFF4D1C),
                                          Color(0xFFFC4010),
                                          Color(0xFFFA6401),
                                          Color(0xFFFF7623),
                                          Color(0xFFFF7623),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(140),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(ImageConstant.coin),
                                          height: 24,
                                        ),
                                        Gap(5),
                                        Text(
                                          'Get 10',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Daily Check-In',
                                      style: TextStyle(
                                        color: Color(0xFF1E1E1E),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Complete 0/3',
                                      style: TextStyle(
                                        color: Color(0xFF787878),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.center,
                                  width: width / 3.5,
                                  height: height / 22,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      // center: Alignment(1.04, 0.59),
                                      // radius: 0.57,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFD6C25),
                                        Color(0xFFFF4D1C),
                                        Color(0xFFFC4010),
                                        Color(0xFFFA6401),
                                        Color(0xFFFF7623),
                                        Color(0xFFFF7623),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(140),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(ImageConstant.coin),
                                        height: 24,
                                      ),
                                      Gap(5),
                                      Text(
                                        'Get 15',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Gap(20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '',
                                      style: TextStyle(
                                        color: Color(0xFF1E1E1E),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Complete 0/2',
                                      style: TextStyle(
                                        color: Color(0xFF787878),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.center,
                                  width: width / 3.5,
                                  height: height / 22,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      // center: Alignment(1.04, 0.59),
                                      // radius: 0.57,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFD6C25),
                                        Color(0xFFFF4D1C),
                                        Color(0xFFFC4010),
                                        Color(0xFFFA6401),
                                        Color(0xFFFF7623),
                                        Color(0xFFFF7623),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(140),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(ImageConstant.coin),
                                        height: 24,
                                      ),
                                      Gap(5),
                                      Text(
                                        'Get 20',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Gap(20),
                            Row(
                              children: [
                                Text(
                                  'Play Quiz & Win Now',
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.center,
                                  width: width / 3.5,
                                  height: height / 22,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      // center: Alignment(1.04, 0.59),
                                      // radius: 0.57,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFD6C25),
                                        Color(0xFFFF4D1C),
                                        Color(0xFFFC4010),
                                        Color(0xFFFA6401),
                                        Color(0xFFFF7623),
                                        Color(0xFFFF7623),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(140),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(ImageConstant.coin),
                                        height: 24,
                                      ),
                                      Gap(5),
                                      Text(
                                        'Get 20',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(20),
                      Container(
                        width: width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Image.asset(ImageConstant.invite),
                            Gap(10),
                            Text(
                              'Invite your friends',
                              style: TextStyle(
                                color: Color(0xFF1E1E1E),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.center,
                              width: width / 3.5,
                              height: height / 22,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  // center: Alignment(1.04, 0.59),
                                  // radius: 0.57,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFD6C25),
                                    Color(0xFFFF4D1C),
                                    Color(0xFFFC4010),
                                    Color(0xFFFA6401),
                                    Color(0xFFFF7623),
                                    Color(0xFFFF7623),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(140),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(ImageConstant.coin),
                                    height: 24,
                                  ),
                                  Gap(5),
                                  Text(
                                    'Get 20',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
