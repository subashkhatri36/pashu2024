import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/sel_model.dart';
import 'package:pasuhisab/app/modules/chickensellreport/bindings/chickensellreport_binding.dart';
import 'package:pasuhisab/app/modules/chickensellreport/views/chickensellreport_view.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/simple_info_row_data.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/date_widget.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';
import 'package:pasuhisab/app/modules/widgets/table/single_column_table.dart';

import '../controllers/chickensell_controller.dart';

class ChickensellView extends GetView<ChickensellController> {
  @override
  Widget build(BuildContext context) {
    final splash = Get.find<SplashController>();
    final hcontroller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(chicken.tr + ' ' + selling.tr),
        actions: [
          IconButton(
              onPressed: () {
                controller.sellinglist.clear();
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Get.to(ChickensellreportView(),
                    binding: ChickensellreportBinding());
              },
              icon: Icon(Icons.receipt_long))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: controller.formey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(borderRadius / 4),
                child: Column(children: [
                  Text(
                    add.tr + ' ' + chicken.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textMultiplier * 1.2,
                    ),
                  ),
                  DateWidget(
                      controller: controller,
                      nepalidate: splash.dateNepali.value),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: controller.qtyController,
                          round: true,
                          hintText: qty.tr,
                          keyboardtype: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: controller.kgController,
                          round: true,
                          hintText: kg.tr,
                          keyboardtype: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          borderRadius: borderRadius,
                          label: clear.tr,
                          onPressed: () {
                            controller.clearData();
                          },
                        ),
                      ),
                      SizedBox(width: SizeConfig.heightMultiplier / 2),
                      Expanded(
                        child: CustomButton(
                          borderRadius: borderRadius,
                          label: add.tr,
                          onPressed: () {
                            controller.addData();
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Container(
                child: Row(
                  children: [
                    SingelColumnTable(fl: 1, header: true, text: sn.tr),
                    SingelColumnTable(fl: 1, header: true, text: qty.tr),
                    SingelColumnTable(fl: 2, header: true, text: kg.tr),
                    SingelColumnTable(fl: 1, header: true, text: rm.tr),
                  ],
                ),
              ),
              Expanded(
                  flex: 9,
                  child: Obx(() => controller.sellinglist == null
                      ? Center(
                          child: Text(nodatafound.tr),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: controller.sellinglist.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    Sel s = controller.sellinglist[index];
                                    return ChickenRawSellField(
                                      kg: s.kg,
                                      qty: s.qty,
                                      sn: index + 1,
                                    );
                                  }),
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(() => SmallInfoDisplay(
                                        title: qty.tr + ': ',
                                        value: controller.qty.value,
                                        border: Colors.grey,
                                      )),
                                ),
                                Expanded(
                                  child: Obx(() => SmallInfoDisplay(
                                        title: kg.tr + ': ',
                                        d: true,
                                        val: controller.kg.value,
                                        border: Colors.grey,
                                      )),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: borderRadius / 5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          average.tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Obx(() => Text(
                                              controller.average
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width: SizeConfig.heightMultiplier / 2),
                                  Expanded(
                                    child: CustomButton(
                                      borderRadius: borderRadius,
                                      label: save.tr,
                                      onPressed: () {
                                        controller.saveContinue(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))),
            ],
          ),
        ),
      ),
    );
  }
}

class ChickenRawSellField extends StatelessWidget {
  const ChickenRawSellField({
    Key? key,
    required this.sn,
    required this.qty,
    required this.kg,
  }) : super(key: key);
  final int sn;
  final int qty;
  final double kg;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChickensellController>();
    return Column(
      children: [
        Row(
          children: [
            SingelColumnTable(fl: 1, header: false, text: sn.toString()),
            SingelColumnTable(fl: 1, header: false, text: qty.toString()),
            SingelColumnTable(fl: 2, header: false, text: kg.toString()),
            SingelColumnTable(
              fl: 1,
              header: false,
              text: 'X',
              onPressed: () {
                controller.removeFromList(sn - 1);
              },
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
