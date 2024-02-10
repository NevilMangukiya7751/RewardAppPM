// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reward_app/data/SharedPreferences/preferences.dart';
import 'package:reward_app/util/images/imageConstant.dart';

class GiftScreen extends StatefulWidget {
  const GiftScreen({super.key});

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("GiftScreen...");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Your Gift",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        flexibleSpace: Container(
          // width: 550,
          // height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.appbar),
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              // height: 80,
              width: width,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(ImageConstant.bg2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Color(0xffFE5C21),
                        ),
                      ),
                      Gap(10),
                      Text(
                        '${Preferences.getTotalAmount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Gap(5),
                      Text(
                        'Coins',
                        style: TextStyle(
                          color: Color(0xFFDADADA),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      childAspectRatio: 8 / 10,
                      mainAxisSpacing: 5),
                  itemCount: giftList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset(giftList[index].image),
                      ],
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }

  List giftList = [
    GiftList(
        name: "boAt Stone 500 Bluetooth\nwith 12W",
        price: "2000",
        image: ImageConstant.speaker),
    GiftList(
        name: "Apple iPhone 11 (64GB,\nBlack)",
        price: "22000",
        image: ImageConstant.iPhone),
    GiftList(
        name: "MI Xiaomi Beard Trimmer\nfor Men",
        price: "1554",
        image: ImageConstant.trimmer),
    GiftList(
        name: "Ambrane 20000mAh\nPower Bank with 20W",
        price: "1750",
        image: ImageConstant.powerBank),
    GiftList(
        name: "Wesley office Laptop\nBag",
        price: "4500",
        image: ImageConstant.bag),
    GiftList(
        name: "Air Purifier 150 with True\nHEPA H13 Filter",
        price: "6500",
        image: ImageConstant.air),
    GiftList(
        name: "SanDisk 16 GB Pen\nDrive (Red)",
        price: "30000",
        image: ImageConstant.penDrive),
    GiftList(
        name: "boAt Airdopes 141 ANC\nTWS Earbuds",
        price: "10000",
        image: ImageConstant.earbuds),
    GiftList(
        name: "CaseBase Mag-Safe\nfor 12/14 Mini Pro Max",
        price: "20000 ",
        image: ImageConstant.magSafe),
  ];
}

class GiftList {
  String name;
  String image;
  String price;

  GiftList({
    required this.name,
    required this.price,
    required this.image,
  });
}
