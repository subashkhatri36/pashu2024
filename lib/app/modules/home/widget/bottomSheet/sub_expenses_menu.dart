import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/other.dart';
import 'package:pasuhisab/app/modules/dana/bindings/dana_binding.dart';
import 'package:pasuhisab/app/modules/dana/views/dana_view.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/add_bhush.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/add_labor.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/add_medicine.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/add_other_expenses.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/electricity_rend_water_add.dart';
import 'package:pasuhisab/app/modules/home/widget/menu/sub_menu_click_menu.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';

class ExpensesMenu extends StatelessWidget {
  const ExpensesMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return BorderContainer(
        widget: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Text(
                    add.tr + ' ' + expenses.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.textMultiplier * 1.4),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                ]),
          ),
          ClickMenu(
            onPressed: () {
              navigator?.pop();
              Get.to(DanaView(), binding: DanaBinding());
            },
            text: dana.tr,
          ),
          ClickMenu(
            onPressed: () {
              navigator?.pop();
              Get.bottomSheet(BhushAdd());
            },
            text: bhus.tr,
          ),
          ClickMenu(
            onPressed: () {
              navigator?.pop();
              Get.bottomSheet(AddMedicine());
            },
            text: medicine.tr,
          ),
          ClickMenu(
            onPressed: () {
              navigator?.pop();
              Get.bottomSheet(EleRentWater());
            },
            text: electricity.tr + ',' + rent.tr + ',' + water.tr,
          ),
          ClickMenu(
            onPressed: () {
              navigator?.pop();
              Get.bottomSheet(AddLabor());
            },
            text: labor.tr,
          ),
          ClickMenu(
            onPressed: () {
              navigator?.pop();
              //inocme true expenses false
              Get.bottomSheet(OtherExpenses(
                inout: false,
                updateed: false,
                model: OtherModel(
                  inout: false,
                  total: 0,
                  challid: 0,
                  remarks: '',
                  enterdate: DateTime.now(),
                ),
              ));
            },
            text: other.tr + ' ' + expenses.tr,
          ),
        ],
      ),
    ));
  }
}
