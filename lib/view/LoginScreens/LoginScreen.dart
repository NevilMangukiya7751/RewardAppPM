// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/Global/Global.dart';
import '../../util/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Let’s get to know each other',
                style: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
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
              SizedBox(height: 20),
              TextFormField(
                controller: phoneController,
                cursorColor: Color(0xFFE0E0E0),
                keyboardType: TextInputType.number,
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
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    /*  User? user = await FirebaseAuthHelper.firebaseAuthHelper
                        .signUpUser(
                            email: nameController.text,
                            password: phoneController.text)
                        .then((value) {
                      FirebaseAuthHelper.firebaseAuthHelper
                          .signInUser(
                              email: nameController.text,
                              password: phoneController.text)
                          .then((value) {
                        log(value!.email!);
                        Navigator.pushReplacementNamed(
                            context, RoutesName.rewardScreen);
                      });
                    });

                    log("user ${user!.email}");*/
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();

                    setState(() {
                      pref.setString(Globals.nameKey, nameController.text);
                      pref.setString(Globals.mobileKey, phoneController.text);
                    });
                    if (nameController.text.isEmpty &&
                        phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "Enter Valid Credintials",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )));
                    } else {
                      if (phoneController.text.length == 10) {
                        Navigator.pushReplacementNamed(
                            context, RoutesName.rewardScreen);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter Valid Number")));
                      }
                    }
                  },
                  child: Container(
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
                      'Login Now',
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
      ),
    );
  }
}
