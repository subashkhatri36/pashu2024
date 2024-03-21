import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/dana_record.dart';
import 'package:pasuhisab/app/modules/dana/widget/dana_add.dart';
import 'package:pasuhisab/app/modules/dannaconsumption/bindings/dannaconsumption_binding.dart';
import 'package:pasuhisab/app/modules/dannaconsumption/views/dannaconsumption_view.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/simple_info_row_data.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/category_items.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';
import 'package:pasuhisab/app/modules/widgets/table/two_column_table_value.dart';
import 'package:pasuhisab/app/modules/widgets/title_widget.dart';

import '../controllers/dana_controller.dart';

class DanaView extends GetView<DanaController> {
  @override
  Widget build(BuildContext context) {
    final chickController = Get.find<HomeController>();

    controller.getAllDana(chickController.challid.value);

    return Scaffold(
      appBar: AppBar(
        title: Text(dana.tr),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => DannaconsumptionView(),
                    binding: DannaconsumptionBinding());
              },
              icon: Icon(Icons.report)),
          IconButton(
              onPressed: () {
                controller.getAllDana(chickController.challid.value);
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
          controller: controller.scroll,
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * .9,
                  child: DanaAdd()),
              BorderContainer(
                widget: Column(
                  children: [
                    Obx(() => TwoColumnTableRow(
                          field: total.tr + ' ' + dana.tr,
                          value: controller.totalDana.value,
                          rsbool: false,
                        )),
                    Obx(() => controller.isloading.isTrue
                        ? TwoColumnTableRow(
                            field: 'B0',
                            value: 0,
                            bold: false,
                          )
                        : controller.b0 == null
                            ? TwoColumnTableRow(
                                field: 'B0',
                                value: 0,
                                bold: false,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.b0.length,
                                itemBuilder: (context, index) {
                                  Dana element = controller.b0[index];
                                  controller.colorindex <= index
                                      ? controller.colorindex = index
                                      : controller.colorindex = 0;

                                  return TwoColumnTableRow(
                                    field:
                                        'B0 (${element.qty} X ${element.rate})',
                                    value: element.qty * element.rate,
                                    bold: false,
                                    color: controller
                                        .colors[controller.colorindex],
                                  );
                                })),
                    Obx(() => controller.isloading.isTrue
                        ? TwoColumnTableRow(
                            field: 'B1',
                            value: 0,
                            bold: false,
                          )
                        : controller.b1 == null
                            ? TwoColumnTableRow(
                                field: 'B1',
                                value: 0,
                                bold: false,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.b1.length,
                                itemBuilder: (context, index) {
                                  Dana element = controller.b1[index];
                                  controller.colorindex <= index
                                      ? controller.colorindex = index
                                      : controller.colorindex = 0;

                                  return TwoColumnTableRow(
                                    field:
                                        'B1 (${element.qty} X ${element.rate})',
                                    value: element.qty * element.rate,
                                    bold: false,
                                    color: controller
                                        .colors[controller.colorindex],
                                  );
                                })),
                    Obx(() => controller.isloading.isTrue
                        ? TwoColumnTableRow(
                            field: 'B2',
                            value: 0,
                            bold: false,
                          )
                        : controller.b2 == null
                            ? TwoColumnTableRow(
                                field: 'B2',
                                value: 0,
                                bold: false,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.b2.length,
                                itemBuilder: (context, index) {
                                  Dana element = controller.b2[index];
                                  controller.colorindex <= index
                                      ? controller.colorindex = index
                                      : controller.colorindex = 0;

                                  return TwoColumnTableRow(
                                    field:
                                        'B2 (${element.qty} X ${element.rate})',
                                    value: element.qty * element.rate,
                                    bold: false,
                                    color: controller
                                        .colors[controller.colorindex],
                                  );
                                })),
                    Obx(() => controller.isloading.isTrue
                        ? TwoColumnTableRow(
                            field: 'L3',
                            value: 0,
                            bold: false,
                          )
                        : controller.l3 == null
                            ? TwoColumnTableRow(
                                field: 'L3',
                                value: 0,
                                bold: false,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.l3.length,
                                itemBuilder: (context, index) {
                                  Dana element = controller.l3[index];
                                  controller.colorindex <= index
                                      ? controller.colorindex = index
                                      : controller.colorindex = 0;

                                  return TwoColumnTableRow(
                                    field:
                                        'L3 (${element.qty} X ${element.rate})',
                                    value: element.qty * element.rate,
                                    bold: false,
                                    color: controller
                                        .colors[controller.colorindex],
                                  );
                                })),
                    Divider(),
                    Obx(() => TwoColumnTableRow(
                          field: total.tr,
                          value: controller.totalsum.value,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: borderRadius / 3,
              ),
              Obx(() => controller.isloading.isTrue
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.danaMainList == null
                      ? Center(
                          child: Text(
                            nodatafound.tr,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : BorderContainer(
                          withtitle: true,
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleWidget(
                                color: Colors.grey,
                                title: dana.tr + ' In',
                                msg: 'Click Row for more options.',
                              ),
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.danaMainList.length,
                                  itemBuilder: (context, index) {
                                    Dana element =
                                        controller.danaMainList[index];
                                    element.total = element.rate * element.qty;
                                    return DanaDetailItems(
                                        dana: element, index: index);
                                  })
                              // ...controller.danaMainList.map(
                              //   (element) => DanaDetailItems(dana: element),
                              // ),
                            ],
                          )))
            ],
          )),
    );
  }
}

class DanaDetailItems extends StatefulWidget {
  const DanaDetailItems({
    Key? key,
    required this.dana,
    this.index = 0,
  }) : super(key: key);
  final Dana dana;
  final int index;

  @override
  _DanaDetailItemsState createState() => _DanaDetailItemsState();
}

class _DanaDetailItemsState extends State<DanaDetailItems> {
  final controller = Get.find<DanaController>();
  int conumption = 0;
  bool finished = false;
  @override
  void initState() {
    super.initState();
    loadconmp();
  }

  loadconmp() async {
    int a = await controller.getDanaConsume(id: widget.dana.id);
    widget.dana.consume = (a ?? 0) > 0 ? a : 0;
    setState(() {
      conumption = (a ?? 0) ?? 0;
      if (widget.dana.qty == conumption + (widget.dana.dreturn ?? 0)) {
        finished = true;
      } else {
        finished = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hcontroller = Get.find<HomeController>();
    final splash = Get.find<SplashController>();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date.tr +
                  ': ${DateFormat('yyyy-MM-dd ').format(widget.dana.enterdate)}  | ' +
                  billno.tr +
                  ': ${widget.dana.billno}'),
              finished
                  ? CategoryItem(
                      icon: true,
                      icondata: Icons.check,
                      backgroundColor: Colors.green,
                    )
                  : PopupMenuButton(
                      onSelected: (int index) async {
                        if (controller.menulist[index] ==
                            controller.menulist[0]) {
                          controller.selectedForUpdate(widget.dana);
                        } else if (controller.menulist[index] ==
                            controller.menulist[1]) {
                          Get.bottomSheet(DanaConsumptionWidget(
                            id: widget.dana.id,
                            index: widget.index,
                            retu: true,
                          ));
                        } else {
                          await controller.deleteDana(context,
                              id: widget.dana.id, index: index);
                          await hcontroller.totalExpenses();
                        }
                      },
                      child: Center(child: Icon(Icons.more_horiz)),
                      itemBuilder: (context) {
                        return List.generate(controller.menulist.length,
                            (index) {
                          return PopupMenuItem(
                            value: index,
                            child: Text(controller.menulist[index].toString()),
                          );
                        });
                      },
                    ),
            ],
          ),
          InkWell(
            onTap: () {
              if (!finished)
                Get.bottomSheet(
                  DanaConsumptionWidget(
                    id: widget.dana.id,
                    index: widget.index,
                    consume: widget.dana.consume,
                  ),
                );
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SmallInfoDisplay(
                        title: widget.dana.dana + ': ',
                        value: widget.dana.qty,
                        border: Colors.grey,
                        rsize: splash.nepaliLanguage.value ? true : false,
                      ),
                    ),
                    Expanded(
                      child: SmallInfoDisplay(
                        title: rate.tr + ': ',
                        value: widget.dana.rate,
                        border: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: SmallInfoDisplay(
                        title: total.tr + ': ',
                        value: widget.dana.qty * widget.dana.rate,
                        border: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SmallInfoDisplay(
                        title: consume.tr + ': ',
                        value: conumption,
                        border: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: SmallInfoDisplay(
                        title: ret.tr + ': ',
                        value: widget.dana.dreturn,
                        border: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: borderRadius / 4),
                Text(
                  note.tr + ' Please Click Box To Enter Daily Consumption',
                  style: TextStyle(fontSize: SizeConfig.textMultiplier - 5),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DanaConsumptionWidget extends StatelessWidget {
  const DanaConsumptionWidget(
      {Key? key,
      required this.id,
      this.consume = 0,
      required this.index,
      this.retu = false})
      : super(key: key);
  final int id;
  final int consume;
  final int index;
  final bool retu;

  @override
  Widget build(BuildContext context) {
    //final splash = Get.find<SplashController>();
    final controller = Get.find<DanaController>();
    final hcontroller = Get.find<HomeController>();
    return BorderContainer(
      background: Colors.white,
      widget: SingleChildScrollView(
        child: Column(children: [
          Text(
            retu ? dana.tr + ' ' + ret.tr : dana.tr + ' ' + 'consumption',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textMultiplier * 1.2,
            ),
          ),
          CustomTextField(
            controller: controller.conqtyController,
            round: true,
            hintText: qty.tr + ' ' + use.tr,
            keyboardtype: TextInputType.number,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    borderRadius: borderRadius,
                    label: close.tr,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: SizeConfig.heightMultiplier / 2),
                Expanded(
                  child: CustomButton(
                    borderRadius: borderRadius,
                    label: save.tr,
                    onPressed: () async {
                      if (retu) {
                        await controller.updateReturn(
                            hcontroller.challid.value, index, context);
                      } else
                        await controller.addConsumption(
                            hcontroller.challid.value, id, index, context);

                      await controller.getAllDana(hcontroller.challid.value);
                      await hcontroller.totalExpenses();
                    },
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

/*
RichText(
                              text: TextSpan(
                                  text: 'Dana :',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' B0',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                         ),
                                      // recognizer: TapGestureRecognizer()
                                      //   ..onTap = () {
                                      //     // navigate to desired screen
                                      //   }
                                    )
                                  ]),
                            ),
 */
