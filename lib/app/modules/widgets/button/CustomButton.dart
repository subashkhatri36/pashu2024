import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class CustomButton extends StatelessWidget {
  // final TextEditingController controller;
  final String label;
  final Color? btnColor;
  final VoidCallback? onPressed;
  final Color? labelColor;
  final double? borderRadius;

  const CustomButton({
    Key? key,
    required this.label,
    this.btnColor,
    this.onPressed,
    this.labelColor,
    this.borderRadius = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style:
              TextStyle(color: labelColor, fontSize: SizeConfig.textMultiplier),
        ),
        style: TextButton.styleFrom(
            //  primary: labelColor,
            backgroundColor: btnColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0))),
      ),
    );
  }
}
