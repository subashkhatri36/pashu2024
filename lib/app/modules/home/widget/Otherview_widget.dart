import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/data/model/other.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/other_controller.dart';
import 'package:pasuhisab/app/modules/widgets/table/single_column_table.dart';

class OtherView extends StatelessWidget {
  const OtherView({Key? key, required this.inout}) : super(key: key);
  final bool inout;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtherController>();
    final chick = Get.find<HomeController>();
    controller.loadOtherModel(chick.challid.value, inout);

    return Scaffold(
      appBar: AppBar(
        title: Text('Other DetailView'),
      ),
      body: Obx(() => controller.isloading.isTrue
          ? Center(
              child: CircularProgressIndicator(),
            )
          : controller.otherlist == null
              ? Center(
                  child: Text(nodatafound.tr),
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        SingelColumnTable(text: date.tr, header: true, fl: 3),
                        SingelColumnTable(text: amount.tr, header: true, fl: 3),
                        SingelColumnTable(text: remark.tr, header: true, fl: 4),
                        SingelColumnTable(text: 'Rmv', header: true, fl: 2),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.otherlist.length,
                        itemBuilder: (context, index) {
                          OtherModel otherModel = controller.otherlist[index];
                          return Container(
                              child: Row(
                            children: [
                              SingelColumnTable(
                                  text: DateFormat.yMd()
                                      .format(otherModel.enterdate),
                                  header: false,
                                  fl: 3),
                              SingelColumnTable(
                                  text: otherModel.total.toString(),
                                  header: true,
                                  fl: 3),
                              SingelColumnTable(
                                  text: remark.tr, header: false, fl: 4),
                              SingelColumnTable(
                                text: 'Rmv',
                                header: true,
                                fl: 2,
                                onPressed: () {},
                              ),
                            ],
                          ));
                        }),
                  ],
                )),
    );
  }
}
