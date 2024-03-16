// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reward_app/util/Global/Global.dart';
import 'package:reward_app/util/images/imageConstant.dart';
import 'package:reward_app/util/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/SharedPreferences/preferences.dart';
import '../res/Common.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    getValue();
    log("Setting SCreen");
  }

  getValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      Globals.getNumber = preferences.getString(Globals.mobileKey);
    });

    log("Globals ${Globals.getNumber}");
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              padding: EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  CircleAvatar(),
                  Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Number',
                        style: TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        Globals.getNumber.toString(),
                        style: TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Gap(30),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ImageIcon(
                      AssetImage(ImageConstant.translate),
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Gap(10),
                  Text(
                    'App Language options',
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffD7D7D7),
                  ),
                ],
              ),
            ),
            Gap(20),
            GestureDetector(
              onTap: () {
                log("ss");
                setState(() {
                  Preferences.totalAmount = Preferences.getTotalAmount + 50;
                });
                setAmount();
              },
              child: Container(
                padding: EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ImageIcon(
                        AssetImage(ImageConstant.invite),
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    Gap(10),
                    Text(
                      'Invite Friends',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffD7D7D7),
                    ),
                  ],
                ),
              ),
            ),
            Gap(20),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ImageIcon(
                      AssetImage(ImageConstant.lik),
                      color: Colors.white,
                    ),
                  ),
                  Gap(10),
                  Text(
                    'Rate Watch Video & Earn Money',
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffD7D7D7),
                  ),
                ],
              ),
            ),
            Gap(20),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ImageIcon(
                      AssetImage(ImageConstant.message),
                      color: Colors.white,
                    ),
                  ),
                  Gap(10),
                  Text(
                    'Feedback or Suggestion?',
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffD7D7D7),
                  ),
                ],
              ),
            ),
            Gap(20),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ImageIcon(
                      AssetImage(ImageConstant.secure),
                      color: Colors.white,
                    ),
                  ),
                  Gap(10),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffD7D7D7),
                  ),
                ],
              ),
            ),
            Gap(20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.aboutUsScreen);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ImageIcon(
                        AssetImage(ImageConstant.infoCircle),
                        color: Colors.white,
                      ),
                    ),
                    Gap(10),
                    Text(
                      'About us',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffD7D7D7),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
