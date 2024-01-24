import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class ClickMenu extends StatelessWidget {
  const ClickMenu({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.textMultiplier * 1.2),
      ),
      trailing: Icon(Icons.arrow_forward_ios_sharp),
    );
  }
}
