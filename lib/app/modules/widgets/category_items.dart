import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/constant.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    this.text = '',
    required this.backgroundColor,
    this.icon = false,
    this.icondata,
  }) : super(key: key);
  final String text;
  final Color backgroundColor;
  final bool icon;
  final IconData? icondata;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(borderRadius / 4),
        padding: EdgeInsets.symmetric(
            horizontal: borderRadius, vertical: borderRadius / 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: backgroundColor),
            borderRadius: BorderRadius.circular(borderRadius)),
        child: icon
            ? Icon(
                icondata != null ? icondata : null,
                color: Colors.white,
                size: 10,
              )
            : Text(
                text,
                style: TextStyle(color: Colors.white),
              ));
  }
}
