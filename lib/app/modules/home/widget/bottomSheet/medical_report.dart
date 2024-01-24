import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/medicine.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/medicine_controller.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/table/single_column_table.dart';

class MedicalReport extends StatelessWidget {
  const MedicalReport({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final medical = Get.find<MedicineController>();
    medical.loadMedicine(controller.challid.value);
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
              medicine.tr + ' ' + report.tr,
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
                : medical.medicineList.isEmpty
                    ? Center(
                        child: Text(nodatafound.tr),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: medical.medicineList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Medicine m = medical.medicineList[index];

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
                                    await medical.deleteMedicine(m, context);
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
