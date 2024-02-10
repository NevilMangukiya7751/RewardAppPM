// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reward_app/util/images/imageConstant.dart';
import 'package:reward_app/util/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/Dailog/congratulationDialog.dart';

class RewardScreen2 extends StatefulWidget {
  const RewardScreen2({super.key});

  @override
  State<RewardScreen2> createState() => _RewardScreen2State();
}

class _RewardScreen2State extends State<RewardScreen2> {
  Map<String, int> coinsCollected = {};
  bool canCollect = true;

  @override
  void initState() {
    super.initState();
    loadCoinsCollected();
    checkIfCanCollect();
  }

  Future<void> loadCoinsCollected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    coinsCollected = {
      'Monday': prefs.getInt('coins_collected_Monday') ?? 0,
      'Tuesday': prefs.getInt('coins_collected_Tuesday') ?? 0,
      'Wednesday': prefs.getInt('coins_collected_Wednesday') ?? 0,
      'Thursday': prefs.getInt('coins_collected_Thursday') ?? 0,
      'Friday': prefs.getInt('coins_collected_Friday') ?? 0,
      'Saturday': prefs.getInt('coins_collected_Saturday') ?? 0,
      'Sunday': prefs.getInt('coins_collected_Sunday') ?? 0,
    };
  }

  Future<void> checkIfCanCollect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime lastCollectionTime =
        DateTime.parse(prefs.getString('last_collection_time') ?? '');

    DateTime now = DateTime.now();
    Duration difference = now.difference(lastCollectionTime);

    if (difference.inSeconds < 3) {
      setState(() {
        canCollect = false;
      });
    }
  }

  Future<void> collectCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the user can collect
    if (canCollect) {
      // Increment coins collected for the current day
      String weekday = DateTime.now().toUtc().weekday.toString();
      int collected = coinsCollected[weekday] ?? 0;
      collected++;
      coinsCollected[weekday] = collected;
      prefs.setInt('coins_collected_$weekday', collected);

      // Save the current collection time
      prefs.setString('last_collection_time', DateTime.now().toIso8601String());

      setState(() {
        canCollect = false;
      });

      // You can add additional logic here for handling the collection process
    }
  }

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
                              '${DateTime.now().toUtc().weekday}:fg ${coinsCollected[DateTime.now().toUtc().weekday.toString()] ?? 0}',
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
                                    (canCollect)
                                        ? Image.asset(
                                            ImageConstant.coin30,
                                            scale: 4,
                                          )
                                        : Image.asset(
                                            ImageConstant.collectedCoin30,
                                            scale: 4,
                                          ),
                                    SizedBox(height: 5),
                                    (canCollect)
                                        ? Text(
                                            'Day 5',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: (canCollect)
                                                  ? Color(0xFF808080)
                                                  : Colors.yellow,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        : Image.asset(
                                            ImageConstant.done,
                                            scale: 4,
                                          ),
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
                            canCollect
                                ? Center(
                                    child: GestureDetector(
                                      onTap: canCollect ? collectCoins : null,
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
                                  )
                                : Container(),
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
                                      'Watch Reward Ad',
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
