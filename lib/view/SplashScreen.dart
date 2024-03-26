// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reward_app/util/Global/Global.dart';
import 'package:reward_app/util/images/imageConstant.dart';
import 'package:reward_app/util/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AdHelper/app_constrant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  String? storeValue;
  getValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      storeValue = preferences.getString(Globals.mobileKey);
    });

    log("glooo $storeValue");

    if (storeValue != null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RoutesName.rewardScreen);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getValue();

    _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

  InterstitialAd? _interstitialAd;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? androidGoogleBanner
          : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  void _prepareInterstitialAd() {
    InterstitialAd.load(
      adUnitId: androidGoogleInterstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (currentAd) {
        currentAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (currentAd) {
          // Navigator.pushNamed(context, RoutesName.chooseLaunguageScreen);
          Navigator.pushReplacementNamed(
              context, RoutesName.chooseLaunguageScreen);
        });
        setState(() {
          _interstitialAd = currentAd;
          _interstitialAd!.show();
        });
      }, onAdFailedToLoad: (error) {
        print("Failed to load : Flutter AdMob Interstitial Ad");
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? Container(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          : null,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2),
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
              SizedBox(height: 20),
              Text(
                'Watch Video &\nDaily Earn Money',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFFA6401),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(flex: 2),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RoutesName.chooseLaunguageScreen);
                  // _prepareInterstitialAd();
                  // FullScreenContentCallback<InterstitialAd>?
                  //     fullScreenContentCallback = FullScreenContentCallback(
                  //         onAdDismissedFullScreenContent: (currentAd) {
                  //   log("aaa ===================================");
                  //   // Navigator.pushNamed(context, RoutesName.chooseLaunguageScreen);
                  //   Navigator.pushReplacementNamed(
                  //       context, RoutesName.chooseLaunguageScreen);
                  // });
                  // AdmobHelper().createInterstitial(fullScreenContentCallback);
                  // Navigator.pushNamed(
                  //     context, RoutesName.chooseLaunguageScreen);
                  // Navigator.pushReplacementNamed(
                  //     context, RoutesName.chooseLaunguageScreen);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: width / 2,
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
