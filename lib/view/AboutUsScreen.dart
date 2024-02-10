// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../util/images/imageConstant.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    log("AboutUsScreen...");
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About us',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        // alignment: Alignment.center,
        child: Column(
          children: [
            Gap(20),
            Container(
              height: height / 4.5,
              width: width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(ImageConstant.logo),
                ),
              ),
            ),
            Gap(20),
            Text(
              'Watch Video & Earn Money',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFA6401),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(20),
            Text(
              'Version 1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 14,
                fontFamily: 'Arboria-Book',
                fontWeight: FontWeight.w400,
                height: 0,
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
                      AssetImage(ImageConstant.refresh),
                      color: Colors.white,
                    ),
                  ),
                  Gap(10),
                  Text(
                    'Check for Updates',
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
          ],
        ),
      ),
    );
  }
}
