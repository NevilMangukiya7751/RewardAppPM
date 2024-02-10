// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../util/routes/routes_name.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  int value = 0;
  bool isMaleSelected = true;
  bool isFemaleSelected = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your gender to peoples',
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMaleSelected = !isMaleSelected;
                      isFemaleSelected = false;
                    });
                  },
                  child: Container(
                    height: 97,
                    padding: EdgeInsets.all(15),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1,
                            color: isMaleSelected ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.male,
                          size: 50,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Male',
                          style: TextStyle(
                            color: Color(0xFFFA6401),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFemaleSelected = !isFemaleSelected;
                      isMaleSelected = false;
                    });
                  },
                  child: Container(
                    height: 97,
                    padding: EdgeInsets.all(15),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1,
                            color:
                                isFemaleSelected ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.female,
                          size: 50,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Female',
                          style: TextStyle(
                            color: Color(0xFFFA6401),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RoutesName.loginScreen);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        Color(0xffFF4D1C),
                        Color(0xffFD6C25),
                        Color(0xffFF7624),
                      ])),
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.70,
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
}
