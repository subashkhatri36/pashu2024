import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/simple_info_row_data.dart';

class DanaInfo extends StatelessWidget {
  const DanaInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
              dana.tr + ' (${controller.totalDana.value}) ' + bora.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.textMultiplier * 1.1),
            )),
        SizedBox(
          height: 5,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SmallInfoDisplay(
                  title: 'B0: ',
                  value: controller.totalb0.value,
                  border: Colors.grey,
                ),
              ),
              Expanded(
                child: SmallInfoDisplay(
                  title: 'B1: ',
                  value: controller.totalb1.value,
                  border: Colors.grey,
                ),
              ),
              Expanded(
                child: SmallInfoDisplay(
                  title: 'B2: ',
                  value: controller.totalb2.value,
                  border: Colors.grey,
                ),
              ),
              Expanded(
                child: SmallInfoDisplay(
                  title: 'l3: ',
                  value: controller.totall3.value,
                  border: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
