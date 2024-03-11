// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reward_app/util/routes/routes.dart';
import 'package:reward_app/util/routes/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBLLw7Ew5pEbQF6U5WqFF03F2n6CRvlDhw",
      appId: "1:911567502179:android:3e21bf3fec4fa2c0333156",
      messagingSenderId: "911567502179",
      projectId: "rewardapp-20e40",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Montserrat",
      ),
      initialRoute: RoutesName.splashScreen,
      // home: RewardScreen3(),
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
