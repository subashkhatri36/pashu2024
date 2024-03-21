import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/data/model/chall_selling_record.dart';
import 'package:pasuhisab/app/data/model/sel_model.dart';
import 'package:pasuhisab/app/modules/addselling/bindings/addselling_binding.dart';
import 'package:pasuhisab/app/modules/addselling/views/addselling_view.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/simple_info_row_data.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/table/two_column_table_value.dart';
import 'package:pasuhisab/app/modules/widgets/title_widget.dart';

import '../controllers/chickensellreport_controller.dart';

class ChickensellreportView extends GetView<ChickensellreportController> {
  final chickcontroller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    controller.loadingSelling(chickcontroller.challid.value);
    return Scaffold(
      appBar: AppBar(
        title: Text(chicken.tr + ' ' + report.tr),
        actions: [
          IconButton(
              onPressed: () {
                controller.loadingSelling(chickcontroller.challid.value);
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Column(
          children: [
            BorderContainer(
                widget: Column(
              children: [
                Obx(() => TwoColumnTableRow(
                      field: total.tr + ' ' + qty.tr,
                      value: controller.totalQty.value,
                      rsbool: false,
                    )),
                Obx(() => TwoColumnTableRow(
                      field: total.tr + ' ' + kg.tr,
                      d: true,
                      dvalue: controller.totalKg.value,
                      rsbool: false,
                    )),
                Obx(() => TwoColumnTableRow(
                      field: maxx.tr + ' ' + average.tr,
                      d: true,
                      dvalue: controller.maxAverage.value,
                      rsbool: false,
                    )),
                Obx(() => TwoColumnTableRow(
                      field: maxx.tr + ' ' + rate.tr,
                      value: controller.maxRate.value,
                    )),
                Obx(() => TwoColumnTableRow(
                      field: travel.tr + ' ' + cost.tr,
                      value: controller.travelcost.value,
                      color: Colors.red,
                    )),
                Divider(),
                Obx(() => TwoColumnTableRow(
                      field: total.tr + ' ' + amount.tr,
                      value: controller.totalAmount.value,
                      color: Colors.green,
                    )),
              ],
            )),
            Divider(),
            Obx(() => controller.isloading.isTrue
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.sellinglist == null
                    ? Center(
                        child: Text(nodatafound.tr),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.sellinglist.length,
                        itemBuilder: (context, index) {
                          Selling sel = controller.sellinglist[index];
                          return ChickenSellField(
                            sel: sel,
                            index: index,
                          );
                        })),
          ],
        )),
      ),
    );
  }
}

class ChickenSellField extends StatelessWidget {
  const ChickenSellField({
    Key? key,
    required this.sel,
    required this.index,
  }) : super(key: key);
  final Selling sel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChickensellreportController>();
    final hcontroller = Get.find<HomeController>();
    return BorderContainer(
        withtitle: true,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              color: Colors.grey,
              title: DateFormat('yyyy-MM-dd ').format(sel.enterdate),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(average.tr +
                          ':' +
                          sel.average.toStringAsFixed(2) +
                          ' ' +
                          kg.tr),
                      PopupMenuButton(
                        onSelected: (int index) async {
                          if (controller.menulist[index] ==
                              controller.menulist[0]) {
                            Sel s = Sel(qty: 0, kg: 0);
                            Get.to(() => AddsellingView(),
                                binding: AddsellingBinding(),
                                arguments: [s, 'Edit', sel]);
                          } else if (controller.menulist[index] ==
                              controller.menulist[1]) {
                            await controller.deleteChickenReport(sel.id, index);
                            await hcontroller.totalIncomeMethod();
                          }
                        },
                        child: Center(child: Icon(Icons.more_horiz)),
                        itemBuilder: (context) {
                          return List.generate(controller.menulist.length,
                              (index) {
                            return PopupMenuItem(
                              value: index,
                              child:
                                  Text(controller.menulist[index].toString()),
                            );
                          });
                        },
                      ),
                      //IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SmallInfoDisplay(
                              title: qty.tr + ': ',
                              value: sel.piece,
                              border: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: SmallInfoDisplay(
                              title: kg.tr + ': ',
                              d: true,
                              val: sel.kg,
                              border: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: SmallInfoDisplay(
                              title: rate.tr + ': ',
                              value: sel.rate,
                              border: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SmallInfoDisplay(
                              title: travel.tr + ' ' + cost.tr + ': ',
                              value: sel.travel,
                              border: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: SmallInfoDisplay(
                              title: total.tr + ': ',
                              d: true,
                              val: sel.total,
                              border: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: borderRadius / 4),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
