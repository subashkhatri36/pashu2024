import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/table/two_column_table_value.dart';
import 'package:pasuhisab/app/modules/widgets/title_widget.dart';

class ProfitAndLoss extends StatelessWidget {
  const ProfitAndLoss({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return BorderContainer(
        withtitle: true,
        widget: Container(
            child: Column(
          children: [
            TitleWidget(
              title: profit.tr + ' & ' + loss.tr,
            ),
            Obx(() => TwoColumnTableRow(
                field: balance.tr + '(' + plus.tr + ')',
                value: controller.balance.value)),
            Obx(() => TwoColumnTableRow(
                  field: total.tr + ' ' + income.tr + '(+)',
                  value: controller.totalIncome.value,
                  color: Colors.green,
                )),
            Obx(() => TwoColumnTableRow(
                  field: total.tr + ' ' + expenses.tr + '(-)',
                  value: -controller.totalExpenditure.value,
                  color: Colors.red,
                )),
            Divider(),
            Obx(() => controller.profitandloss.value >= 0
                ? TwoColumnTableRow(
                    field: profit.tr,
                    value: controller.profitandloss.value,
                    color: Colors.green,
                  )
                : TwoColumnTableRow(
                    field: loss.tr,
                    value: -controller.profitandloss.value,
                    color: Colors.red,
                  )),
            Divider(),
            Obx(() => TwoColumnTableRow(
                  field: remaning.tr,
                  value: controller.profitandloss.value >= 0
                      ? controller.profitandloss.value
                      : 0,
                  color: Colors.black,
                )),
          ],
        )));
  }
}
