import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/medical_report.dart';
import 'package:pasuhisab/app/modules/home/widget/simple_info_row_data.dart';

class OtherExpensesInfo extends StatelessWidget {
  const OtherExpensesInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          other.tr + ' ' + expenses.tr,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textMultiplier * 1.1),
        ),
        SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallInfoDisplay(
                  title: labor.tr + ': ',
                  value: controller.tatallabor.value > 0
                      ? controller.tatallabor.value
                      : 0,
                ),
                SmallInfoDisplay(
                  onTap: () {
                    Get.bottomSheet(MedicalReport());
                  },
                  title: medicine.tr + ': ',
                  value: controller.totalmedicine.value > 0
                      ? controller.totalmedicine.value
                      : 0,
                  rss: true,
                ),
                SmallInfoDisplay(
                  rss: true,
                  title: bhus.tr + ': ',
                  value: controller.totalbhush.value,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
