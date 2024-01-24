import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/data/model/total_model.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/table/grand_total_table_row.dart';
import 'package:pasuhisab/app/modules/widgets/table/table_header_row.dart';
import 'package:pasuhisab/app/modules/widgets/title_widget.dart';

class TotalExpenditureSummaryWidget extends StatelessWidget {
  const TotalExpenditureSummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return BorderContainer(
        colors: Colors.red,
        withtitle: true,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              color: Colors.red,
              title: expenses.tr,
              msg: clicknote.tr,
            ),
            TableHeaderAndRow(
              particular: particular.tr,
              qty: qty.tr,
              rate: rate.tr,
              total: total.tr,
              header: true,
            ),
            Obx(() => controller.loadExpenses.isTrue
                ? Container()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.totalExpenditureList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      TotalModel element =
                          controller.totalExpenditureList[index];
                      return TableHeaderAndRow(
                        particular: element.name,
                        qty: element.qty == 0 ? '-' : element.qty.toString(),
                        rate: element.rate == 0 ? '-' : element.rate.toString(),
                        total:
                            element.total == 0 ? '-' : element.total.toString(),
                        ontap: element.onTap,
                      );
                    })),
            Obx(() => GrandTotalTableRow(
                  color: Colors.red,
                  fieldName: total.tr + ' ' + expenses.tr,
                  value: controller.totalExpenditure.value,
                ))
          ],
        ));
  }
}
