import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class SmallInfoDisplay extends StatelessWidget {
  const SmallInfoDisplay({
    Key? key,
    this.title = '',
    this.value = 0,
    this.onTap,
    this.rss = false,
    this.val = 0,
    this.d = false,
    this.rsize = false,
    this.border = Colors.transparent,
  }) : super(key: key);
  final String title;
  final int value;
  final Color border;
  final bool rss;
  final VoidCallback? onTap;
  final bool d;
  final double val;
  final bool rsize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? null,
      child: Container(
        padding: rsize
            ? EdgeInsets.all(SizeConfig.heightMultiplier / 1.6)
            : EdgeInsets.all(SizeConfig.heightMultiplier / 2),
        decoration: BoxDecoration(border: Border.all(color: border)),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            d
                ? Text(rss
                    ? rs.tr + val.toStringAsFixed(2) + '/-'
                    : val.toStringAsFixed(2))
                : Text(rss ? rs.tr + value.toString() + '/-' : value.toString())
          ],
        ),
      ),
    );
  }
}
