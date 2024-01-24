import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class BorderContainer extends StatelessWidget {
  const BorderContainer(
      {Key? key,
      this.background = Colors.transparent,
      required this.widget,
      this.colors = Colors.grey,
      this.withtitle = false})
      : super(key: key);
  final Widget widget;
  final background;
  final Color colors;
  final bool withtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier,
          vertical: borderRadius / 3,
        ),
        padding: withtitle
            ? EdgeInsets.only(
                bottom: SizeConfig.widthMultiplier,
                left: SizeConfig.widthMultiplier,
                right: SizeConfig.widthMultiplier)
            : EdgeInsets.all(SizeConfig.widthMultiplier),
        decoration: BoxDecoration(
            color: background,
            border: Border.all(color: colors),
            borderRadius:
                BorderRadius.circular(SizeConfig.heightMultiplier / 2)),
        child: widget);
  }
}
