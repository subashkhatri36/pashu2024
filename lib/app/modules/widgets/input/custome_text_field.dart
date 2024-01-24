import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  // final IconData prefixIcon;
  final String label;
  final Color? hintcolor;
  final VoidCallback? onPressed;
  final onChange;
  final bool obscureText;
  final validator;
  final bool? round;
  final keyboardtype;
  final inputformatter;
  final int? maxline;
  final decoration;

  const CustomTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.hintcolor,
      this.onPressed,
      this.obscureText = false,
      // TextInputType textInputType,
      //  this.prefixIcon,
      this.validator,
      this.round,
      this.label = '',
      this.inputformatter,
      this.onChange,
      this.maxline,
      this.decoration,
      this.keyboardtype})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final style =
        TextStyle(color: hintcolor, fontSize: SizeConfig.textMultiplier - 3);
    return Container(
      margin: EdgeInsets.all(SizeConfig.heightMultiplier / 5),
      // height: SizeConfig.heightMultiplier * 2.3,
      child: TextFormField(
          textAlign: TextAlign.left,
          onChanged: onChange ?? null,
          inputFormatters: inputformatter ?? [],
          keyboardType: keyboardtype ?? TextInputType.text,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          maxLines: maxline ?? 1,
          decoration: decoration ??
              InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 5),
                  hintText: hintText,
                  hintStyle: style,
                  labelStyle: style,
                  // prefixIcon: Icon(prefixIcon),
                  labelText: label,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          (round ?? false) ? borderRadius / 4 : 0.0)))),
    );
  }
}
