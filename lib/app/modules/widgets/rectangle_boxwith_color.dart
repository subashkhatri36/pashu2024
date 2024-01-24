import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class RectangleBox extends StatelessWidget {
  const RectangleBox({
    Key? key,
    this.color = Colors.blue,
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    required this.text,
  }) : super(key: key);
  final Color color;
  final Color borderColor;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.heightMultiplier / 2),
      decoration:
          BoxDecoration(color: color, border: Border.all(color: borderColor)),
      child: Text(text,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.heightMultiplier)),
    );
  }
}
