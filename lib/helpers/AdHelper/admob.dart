import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';
import 'app_constrant.dart';

class AdmobHelper {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  final adUnitId = Platform.isAndroid
      ? androidGoogleRewardAd
      : 'ca-app-pub-3940256099942544/1712485313';

  // IsSilly _isSilly;
  static BannerAd getBannerAd() {
    BannerAd bAd = BannerAd(
        size: AdSize.banner,
        adUnitId: androidGoogleBanner,
        listener: BannerAdListener(
            onAdClosed: (Ad ad) {},
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              ad.dispose();
            },
            onAdLoaded: (Ad ad) {},
            onAdOpened: (Ad ad) {}),
        request: AdRequest());
    return bAd;
  }

  // create interstitial ads
  void createInterstitial(
      FullScreenContentCallback<InterstitialAd>? fullScreenContentCallback) {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = fullScreenContentCallback;
          _interstitialAd = ad;
          _interstitialAd!.show();
        }, onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
        }));
  }

  void rewardAd() {
    RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.

          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          },

          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        )).then((rewardedAd) {
      _rewardedAd!.show(onUserEarnedReward: (ad, RewardItem rewardItem) {
        log("User earned reward: ${rewardItem.amount}");
      });
    });
  }
}
