import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class SingelColumnTable extends StatelessWidget {
  const SingelColumnTable(
      {Key? key,
      required this.text,
      required this.header,
      required this.fl,
      this.onPressed})
      : super(key: key);

  final String text;
  final bool header;
  final int fl;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: fl,
      child: InkWell(
        onTap: onPressed ?? null,
        child: Container(
          padding: EdgeInsets.all(borderRadius / 5),
          decoration: BoxDecoration(
              border: header ? Border.all(color: Colors.grey) : null),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: header ? FontWeight.bold : FontWeight.normal,
                fontSize: SizeConfig.textMultiplier),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
