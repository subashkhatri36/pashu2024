import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdWidget(ad: controller),
      width: MediaQuery.of(context).size.width,
      height: 72.0,
      alignment: Alignment.center,
    );
  }
}
