import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/constant.dart';

class SingleMenuField extends StatelessWidget {
  const SingleMenuField({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: borderRadius / 5, horizontal: borderRadius / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onPressed,
            child: CircleAvatar(
              child: Icon(iconData),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(text)
        ],
      ),
    );
  }
}
