import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/other.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/other_controller.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/table/single_column_table.dart';

class OtherReport extends StatelessWidget {
  const OtherReport({Key? key, required this.inout}) : super(key: key);
  final bool inout;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final medical = Get.find<OtherController>();

    medical.loadOtherModel(controller.challid.value, inout);
    return BorderContainer(
        widget: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(borderRadius / 3),
            child: Text(
              other.tr + ' ' + report.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.textMultiplier * 1.2),
            ),
          ),
          Container(
            child: Row(
              children: [
                SingelColumnTable(fl: 2, header: true, text: date.tr),
                SingelColumnTable(fl: 2, header: true, text: amount.tr),
                SingelColumnTable(fl: 2, header: true, text: remark.tr),
                SingelColumnTable(fl: 1, header: true, text: rm.tr),
              ],
            ),
          ),
          Obx(
            () => medical.isloading.isTrue
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : medical.otherlist == null
                    ? Center(
                        child: Text(nodatafound.tr),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: medical.otherlist.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          OtherModel m = medical.otherlist[index];

                          return Container(
                            child: Row(
                              children: [
                                SingelColumnTable(
                                    fl: 2,
                                    header: false,
                                    text: DateFormat.yMd().format(m.enterdate)),
                                SingelColumnTable(
                                    fl: 2,
                                    header: false,
                                    text: m.total.toString()),
                                SingelColumnTable(
                                    fl: 2, header: false, text: m.remarks),
                                SingelColumnTable(
                                  fl: 1,
                                  header: false,
                                  text: 'X',
                                  onPressed: () async {
                                    await medical.deleteOtherModel(
                                        m.id, context);
                                    await medical.loadOtherModel(
                                        controller.challid.value, inout);
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: borderRadius / 5),
            child: CustomButton(
              borderRadius: borderRadius,
              label: close.tr,
              onPressed: () async {
                await controller.totalIncomeMethod();
                await controller.totalExpenses();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    ));
  }
}
