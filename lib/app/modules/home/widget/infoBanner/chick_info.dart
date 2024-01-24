import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/simple_info_row_data.dart';

class ChickInfo extends StatelessWidget {
  const ChickInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallInfoDisplay(
                title: chick.tr + ': ', value: controller.totalChalla.value),
            SmallInfoDisplay(
                title: dead.tr + ': ', value: controller.deadchalla.value),
            SmallInfoDisplay(
                title: loss.tr + ': ', value: controller.lossamount.value)
          ],
        ));
  }
}
