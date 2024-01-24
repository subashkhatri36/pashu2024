import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/images.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    //   controller.loadPage();

    return Scaffold(
      // backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Image.asset(appLogo), //Image.asset(appLogo),
      ),
    );
  }
}
