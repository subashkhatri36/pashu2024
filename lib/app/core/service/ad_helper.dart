import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5946802346170399/4371243591";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
   static String get bannerAdUnitId1 {
    if (Platform.isAndroid) {
      return "ca-app-pub-5946802346170399/7575817396";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
   static String get bannerAdUnitId2 {
    if (Platform.isAndroid) {
      return "ca-app-pub-5946802346170399/8122612302";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
   static String get bannerAdUnitId3 {
    if (Platform.isAndroid) {
      return "ca-app-pub-5946802346170399/3919643415";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

   static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5946802346170399/8699582407';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }


  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5946802346170399/6073419066";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_NATIVE_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
