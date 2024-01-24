import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/data/model/total_model.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/table/grand_total_table_row.dart';
import 'package:pasuhisab/app/modules/widgets/table/table_header_row.dart';
import 'package:pasuhisab/app/modules/widgets/title_widget.dart';

class IncomeSummaryWidget extends StatelessWidget {
  const IncomeSummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return BorderContainer(
        colors: Colors.green,
        withtitle: true,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              color: Colors.green,
              title: income.tr,
              msg: clicknote.tr,
            ),
            TableHeaderAndRow(
              particular: particular.tr,
              qty: qty.tr,
              rate: rate.tr,
              total: total.tr,
              header: true,
            ),
            Obx(() => controller.loadIncome.isTrue
                ? Container()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.totalIncomeList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      TotalModel model = controller.totalIncomeList[index];

                      return TableHeaderAndRow(
                        particular: model.name,
                        qty: model.qty > 0 ? model.qty.toString() : '-',
                        rate: model.rate > 0 ? model.rate.toString() : '-',
                        total: model.total > 0 ? model.total.toString() : '-',
                        ontap: model.onTap,
                      );
                    })),
            Obx(() => GrandTotalTableRow(
                  color: Colors.green,
                  fieldName: total.tr + ' ' + income.tr,
                  value: controller.totalIncome.value,
                ))
          ],
        ));
  }
}
