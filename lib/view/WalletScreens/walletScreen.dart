// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reward_app/data/SharedPreferences/preferences.dart';

import '../../util/images/imageConstant.dart';
import '../../util/routes/routes_name.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    log("WalletScreen....");
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var value = 0;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // height: height / 3.5,
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Wallet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.giftScreen);
                        },
                        child: Image.asset(
                          ImageConstant.gift,
                          scale: 4,
                        ),
                      )
                    ],
                  ),
                  Gap(10),
                  Text(
                    'Total Balance Points',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Gap(20),
                      Image.asset(
                        ImageConstant.coin,
                        scale: 6,
                      ),
                      Gap(10),
                      Text(
                        Preferences.getTotalAmount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Text(
                    'India 15000 Points = 600 INR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Other Country 15000 Points = 60 USD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Gap(10),
            Text(
              'Minimum Redeem Points\n15000',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(10),
            Text(
              'Select Payment Method',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  paymentOption(0, "assets/images/paytm.png"),
                  paymentOption(1, "assets/images/paypal2.jpg"),
                  paymentOption(2, "assets/images/upi.png"),
                  /*     GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 30, bottom: 30, left: 10, right: 10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffFF7524))),
                      child: Image.asset("assets/images/paytm.png"),
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffFF7524))),
                    child: Image.asset(
                      "assets/images/paypal2.jpg",
                      scale: 2,
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffFF7524))),
                    child: Image.asset("assets/images/upi.png"),
                  ),*/
                ],
              ),
            ),
            Gap(10),
            Text(
              'Enter Payment Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: nameController,
                cursorColor: Color(0xFFE0E0E0),
                decoration: InputDecoration(
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFE0E0E0),
                  )),
                  hintText: "Enter Your Name",
                  hintStyle: TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFE0E0E0),
                  )),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: phoneController,
                cursorColor: Color(0xFFE0E0E0),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Phone Number",
                  hintStyle: TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFE0E0E0),
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFE0E0E0),
                  )),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
            ),
            Gap(20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RoutesName.rewardScreen);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  alignment: Alignment.center,
                  height: 50,
                  width: width,
                  decoration: ShapeDecoration(
                    // borderRadius: BorderRadius.circular(15),
                    gradient: RadialGradient(
                      center: Alignment(1.04, 0.59),
                      radius: 0.57,
                      colors: [
                        Color(0xffFF4D1C),
                        Color(0xffFD6C25),
                        Color(0xffFF7624),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Redeem',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  paymentOption(index, image) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = index;
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color:
                    (value == index) ? Color(0xffFF7524) : Color(0xffE0E0E0))),
        child: Image.asset(image),
      ),
    );
  }
}
