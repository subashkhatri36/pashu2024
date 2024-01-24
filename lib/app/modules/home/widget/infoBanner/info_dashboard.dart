import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/chickensell/bindings/chickensell_binding.dart';
import 'package:pasuhisab/app/modules/chickensellreport/controllers/chickensellreport_controller.dart';
import 'package:pasuhisab/app/modules/chickensellreport/views/chickensellreport_view.dart';
import 'package:pasuhisab/app/modules/dana/bindings/dana_binding.dart';
import 'package:pasuhisab/app/modules/dana/views/dana_view.dart';
import 'package:pasuhisab/app/modules/home/widget/infoBanner/chick_info.dart';
import 'package:pasuhisab/app/modules/home/widget/infoBanner/dana_info.dart';
import 'package:pasuhisab/app/modules/home/widget/infoBanner/other_expenses.dart';
import 'package:pasuhisab/app/modules/home/widget/infoBanner/selling_info.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';

class TopGeneralInfoDashBoard extends StatelessWidget {
  const TopGeneralInfoDashBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ChickensellreportController());
    return Column(
      children: [
        BorderContainer(
            colors: Theme.of(context).primaryColor,
            widget: Column(
              children: [
                ChickInfo(),
                SizedBox(
                  height: SizeConfig.heightMultiplier,
                ),
                InkWell(
                    onTap: () {
                      Get.to(() => DanaView(), binding: DanaBinding());
                    },
                    child: DanaInfo()),
                SizedBox(
                  height: SizeConfig.heightMultiplier,
                ),
                OtherExpensesInfo(),
                SizedBox(
                  height: SizeConfig.heightMultiplier,
                ),
                InkWell(
                    onTap: () {
                      Get.to(() => ChickensellreportView(),
                          binding: ChickensellBinding());
                    },
                    child: SellingInfo()),
              ],
            ))
      ],
    );
  }
}
