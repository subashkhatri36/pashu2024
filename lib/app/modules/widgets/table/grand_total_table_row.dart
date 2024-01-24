import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class GrandTotalTableRow extends StatelessWidget {
  const GrandTotalTableRow({
    Key? key,
    required this.fieldName,
    required this.value,
    required this.color,
  }) : super(key: key);
  final String fieldName;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 8,
              child: Container(
                  padding: EdgeInsets.all(borderRadius / 4),
                  // decoration: BoxDecoration(
                  //     border: Border(right: BorderSide(color: Colors.grey))),
                  child: Text(
                    fieldName,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.textMultiplier),
                  ))),
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(borderRadius / 4),
                // decoration: BoxDecoration(
                //     border: Border(left: BorderSide(color: Colors.grey))),
                child: Text(
                  value.toStringAsFixed(1),
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textMultiplier),
                ),
              )),
        ],
      ),
    );
  }
}
