import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class OneSideCircleButton extends StatelessWidget {
  const OneSideCircleButton({
    Key? key,
    this.left = true,
    this.text = '',
  }) : super(key: key);
  final bool left;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 4,
        margin: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier / 2,
        ),
        padding: EdgeInsets.all(
          SizeConfig.heightMultiplier / 2,
        ),
        decoration: BoxDecoration(
            color: Colors.blue[900],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.only(
              bottomLeft: left ? Radius.circular(borderRadius) : Radius.zero,
              topLeft: left ? Radius.circular(borderRadius) : Radius.zero,
              bottomRight: !left ? Radius.circular(borderRadius) : Radius.zero,
              topRight: !left ? Radius.circular(borderRadius) : Radius.zero,
            )),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.heightMultiplier)));
  }
}
