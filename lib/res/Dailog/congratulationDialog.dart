// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../util/images/imageConstant.dart';

congratulationDialog(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(0),
          content: Container(
            width: double.infinity,
            height: 240,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.57),
              ),
            ),
            child: Column(
              children: [
                Gap(10),
                Image.asset(ImageConstant.award),
                Text(
                  'Congratulation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF3C3C3C),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome Bonus ',
                        style: TextStyle(
                          color: Color(0xFFA0A0A0),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: '500 Coins',
                        style: TextStyle(
                          color: Color(0xFFFA6401),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(50),
                Container(
                  alignment: Alignment.center,
                  // width: width / 3.5,
                  // height: height / 22,
                  width: 163,
                  height: 42,
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
                      borderRadius: BorderRadius.circular(10),
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
                        'Claim Coins',
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
        );
      });
}

congratulationDialog2(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(0),
          content: Container(
            width: double.infinity,
            height: 240,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.57),
              ),
            ),
            child: Column(
              children: [
                Gap(10),
                Text(
                  'Congratulation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF3C3C3C),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(30),
                Image.asset(ImageConstant.cong),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      // width: width / 3.5,
                      // height: height / 22,
                      // width: 163,
                      padding: EdgeInsets.all(10),
                      // height: 42,
                      decoration: ShapeDecoration(
                        color: Color(0xFF14AE5C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow_outlined,
                            color: Colors.white,
                          ),
                          Gap(5),
                          Text(
                            'Claim 2x',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      // width: width / 3.5,
                      // height: height / 22,
                      // width: 163,
                      padding: EdgeInsets.all(10),

                      // height: 42,
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
                          borderRadius: BorderRadius.circular(10),
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
                            'Claim Coins',
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
        );
      });
}
