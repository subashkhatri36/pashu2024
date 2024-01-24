import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
    this.msg = '',
    this.color,
  }) : super(key: key);
  final String title;
  final String msg;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      color: color == null ? Theme.of(context).primaryColor : color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: SizeConfig.textMultiplier * 1.1),
          ),
          if (msg.isNotEmpty)
            SizedBox(
              width: SizeConfig.widthMultiplier / 2,
            ),
          if (msg.isNotEmpty)
            FittedBox(
              child: Text(
                note.tr + ' $msg',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.textMultiplier - 4),
              ),
            )
        ],
      ),
    );
  }
}
