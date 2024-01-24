import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/data/model/dana_consumption.dart';
import 'package:pasuhisab/app/modules/dana/controllers/dana_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/table/single_column_table.dart';

import '../controllers/dannaconsumption_controller.dart';
import 'package:intl/intl.dart';

class DannaconsumptionView extends GetView<DannaconsumptionController> {
  final chickcontroller = Get.find<HomeController>();
  final dcontroller = Get.find<DanaController>();
  @override
  Widget build(BuildContext context) {
    controller.loadingConsumption(chickcontroller.challid.value);
    return Scaffold(
        appBar: AppBar(
          title: Text(dana.tr),
          actions: [
            Obx(() => Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    total.tr + ' ' + controller.total.value.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )))
          ],
        ),
        body: BorderContainer(
            widget: Column(
          children: [
            Row(
              children: [
                SingelColumnTable(text: date.tr, header: true, fl: 4),
                SingelColumnTable(text: dana.tr, header: true, fl: 4),
                SingelColumnTable(text: qty.tr, header: true, fl: 4),
                SingelColumnTable(text: 'Rmv', header: true, fl: 2),
              ],
            ),
            Expanded(
              child: Obx(() => controller.isloading.isTrue
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.danaConsumptionList == null
                      ? Center(
                          child: Text(nodatafound.tr),
                        )
                      : ListView.builder(
                          itemCount: controller.danaConsumptionList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DanaConsumption dc =
                                controller.danaConsumptionList[index];

                            return Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SingelColumnTable(
                                          text: DateFormat('yyyy-MM-dd ')
                                              .format(dc.enterdate)
                                              .toString(),
                                          header: false,
                                          fl: 4),
                                      SingelColumnTable(
                                          text: controller.danaSwitch(dc.dana),
                                          header: false,
                                          fl: 4),
                                      SingelColumnTable(
                                          text: dc.qty.toString(),
                                          header: false,
                                          fl: 4),
                                      SingelColumnTable(
                                          onPressed: () async {
                                            await controller.deleteConsumption(
                                                dc.id, dc, context);
                                            await dcontroller.getAllDana(
                                                chickcontroller.challid.value);
                                          },
                                          text: ' X ',
                                          header: false,
                                          fl: 2),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          })),
            ),
          ],
        )));
  }
}
