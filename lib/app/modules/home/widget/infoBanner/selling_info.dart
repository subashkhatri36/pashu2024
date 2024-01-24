import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/simple_info_row_data.dart';

class SellingInfo extends StatelessWidget {
  const SellingInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selling.tr + ' (' + chicken.tr + ')',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textMultiplier * 1.1),
        ),
        SizedBox(
          height: 5,
        ),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallInfoDisplay(
                  title: t.tr + piece.tr + ': ',
                  value: controller.totalchickenqty.value,
                ),
                SmallInfoDisplay(
                  title: t.tr + weight.tr + ': ',
                  value: controller.totalchickenkg.value,
                ),
                SmallInfoDisplay(
                  title: t.tr + price.tr + ': ',
                  value: controller.maxrate.value,
                ),
              ],
            )),
      ],
    );
  }
}
