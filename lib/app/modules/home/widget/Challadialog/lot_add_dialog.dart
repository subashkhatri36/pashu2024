import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/add_chicks_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/Challadialog/left_part_lots.dart';
import 'package:pasuhisab/app/modules/home/widget/Challadialog/right_part_lot.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';

class AddLotsWidget extends StatelessWidget {
  const AddLotsWidget({
    Key? key,
    this.isdialog = true,
  }) : super(key: key);
  final bool isdialog;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChicksRecordController>();
    final controllr = Get.find<HomeController>();

    return BorderContainer(
      // background: Colors.white,
      widget: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(flex: 4, child: AddLotLeftWidget()),
                Expanded(
                  flex: 6,
                  child: AddLotRightsWidget(),
                )
              ],
            ),
            Container(
              child: Row(
                children: [
                  if (isdialog)
                    SizedBox(
                      width: SizeConfig.widthMultiplier / 2,
                    ),
                  if (isdialog)
                    Expanded(
                      child: CustomButton(
                        borderRadius: borderRadius,
                        label: cancel.tr,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier / 2,
                  ),
                  Expanded(
                    child: CustomButton(
                      borderRadius: borderRadius,
                      label: save.tr,
                      onPressed: () async {
                        await controller.addChalla();
                        if (controller.challRecordList?.length == 1)
                          await controllr
                              .loadSingleChallInof(controller.challaId);
                        await controllr.loadingChicks();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier / 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
