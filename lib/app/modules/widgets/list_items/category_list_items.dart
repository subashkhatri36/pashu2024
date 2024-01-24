import 'package:flutter/material.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/add_chicks_controller.dart';

class CategoryItems extends StatelessWidget {
  final String image;
  final String name;
  final ChicksRecordController? controller;
  final int id;

  const CategoryItems({
    Key? key,
    required this.image,
    required this.name,
    required this.id,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.heightMultiplier / 4,
          bottom: SizeConfig.heightMultiplier / 4,
          left: SizeConfig.heightMultiplier / 4,
          right: SizeConfig.heightMultiplier),
      margin: EdgeInsets.all(SizeConfig.heightMultiplier / 8),
      decoration: BoxDecoration(
          color: controller?.categoryString.value == name
              ? Colors.blueGrey[600]
              : Colors.blueGrey[900],
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: SizeConfig.heightMultiplier / 1.2,
            child: CircleAvatar(
              backgroundColor: controller?.categoryString.value == name
                  ? Colors.blueGrey[600]
                  : Colors.blueGrey[900],
              radius: (SizeConfig.heightMultiplier / 1.2) - 2,
              backgroundImage: AssetImage(image),
            ),
          ),
          SizedBox(width: SizeConfig.widthMultiplier),
          Container(
            // margin: EdgeInsets.only(left: SizeConfig.heightMultiplier+20),
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white, fontSize: SizeConfig.textMultiplier - 3),
            ),
          ),
        ],
      ),
    );
  }
}
