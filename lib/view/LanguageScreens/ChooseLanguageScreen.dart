// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reward_app/util/images/imageConstant.dart';
import 'package:reward_app/util/routes/routes_name.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  int value = 0;

  @override
  void initState() {
    // TODO: implement initState
    log("ChooseLaunguageScreen.......");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Select Language',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF1E1E1E),
              // fontWeight: FontWeight.w400,
            ),
          )),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            language(width, 0, "Hindi", ImageConstant.indianFlag),
            SizedBox(height: 10),
            language(width, 1, "English", ImageConstant.englishFlag),
            SizedBox(height: 10),
            language(width, 2, "Indonesian", ImageConstant.indonesianFlag),
            SizedBox(height: 10),
            language(width, 3, "African", ImageConstant.affricanFlag),
            SizedBox(height: 10),
            language(width, 4, "Spanish", ImageConstant.spanish),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.genderScreen);
              },
              child: Container(
                width: 58,
                height: 58,
                decoration: ShapeDecoration(
                  gradient: RadialGradient(
                    center: Alignment(1.04, 0.59),
                    radius: 0.57,
                    colors: [
                      Color(0xFFFA6401),
                      Color(0xFFFF7623),
                      Color(0xFFFD6C25),
                      Color(0xFFFF4D1C),
                      Color(0xFFFC4010)
                    ],
                  ),
                  shape: OvalBorder(),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  language(width, int index, name, image) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = index;
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 20),
        width: width,
        height: 56,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color: (value == index)
                    ? Color(0xFFFA6401)
                    : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            SizedBox(width: 20),
            Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              height: 20,
              width: 20,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1,
                        color: (value == index)
                            ? Color(0xFFFA6401)
                            : Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  gradient: (value == index)
                      ? LinearGradient(colors: [
                          Color(0xffFF4D1C),
                          Color(0xffFD6C25),
                          Color(0xffFF7624),
                        ])
                      : null),
              child: (value == index)
                  ? Icon(
                      Icons.done,
                      size: 15,
                      color: Colors.white,
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
