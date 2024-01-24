import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/constant.dart';

class TwoColumnTableRow extends StatelessWidget {
  const TwoColumnTableRow({
    Key? key,
    this.color = Colors.black,
    this.bold = true,
    required this.field,
    this.value = 0,
    this.d = false,
    this.dvalue = 0,
    this.rsbool = true,
  }) : super(key: key);
  final Color color;
  final bool bold;
  final String field;
  final int value;
  final bool rsbool;
  final bool d;
  final double dvalue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: borderRadius / 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            field,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: color,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            d
                ? dvalue >= 0
                    ? rsbool
                        ? 'Rs.' + dvalue.toStringAsFixed(1)
                        : dvalue.toStringAsFixed(1)
                    : rsbool
                        ? '-Rs.' + dvalue.abs().toStringAsFixed(1)
                        : '-' + dvalue.abs().toStringAsFixed(1)
                : value >= 0
                    ? rsbool
                        ? 'Rs.' + value.toString()
                        : value.toString()
                    : rsbool
                        ? '-Rs.' + value.abs().toString()
                        : '-' + value.abs().toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
                color: color,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          )
        ],
      ),
    );
  }
}
