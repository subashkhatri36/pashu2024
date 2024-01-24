import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/add_chicks_controller.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/date_widget.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class AddLotRightsWidget extends StatelessWidget {
  const AddLotRightsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChicksRecordController>();
    final splash = Get.find<SplashController>();

    return Form(
      key: controller.formkey,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                add.tr + ' ' + lot.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: SizeConfig.textMultiplier * 1.2,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier / 2,
            ),
            DateWidget(
                controller: controller, nepalidate: splash.dateNepali.value),
            CustomTextField(
              controller: controller.billnoController,
              round: true,
              hintText: billno.tr,
            ),
            CustomTextField(
              controller: controller.qtyController,
              validator: (value) => validateIsEmpty(string: value),
              round: true,
              keyboardtype: TextInputType.number,
              hintText: qty.tr,
              onChange: (value) => controller.calculatetotal(),
            ),
            CustomTextField(
              controller: controller.rateController,
              validator: (value) => validateIsEmpty(string: value),
              keyboardtype: TextInputType.number,
              round: true,
              hintText: rate.tr,
              onChange: (value) => controller.calculatetotal(),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier / 2,
            ),
            Obx(() => Text(
                  total.tr + ' ' + rs.tr + ' ${controller.total.value}/-',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
