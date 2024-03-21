import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class BalanceWidget extends StatelessWidget {
  //ktmros
  const BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    controller.loadBalance();

    return BorderContainer(
        widget: SingleChildScrollView(
      child: Form(
        key: controller.formkey,
        child: Column(
          children: [
            Text(
              balance.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.textMultiplier * 1.2,
              ),
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              controller: controller.amountcontroller,
              round: true,
              hintText: amount.tr,
              keyboardtype: TextInputType.number,
            ),
            CustomTextField(
              validator: (value) => validateIsEmpty(string: value),
              controller: controller.remarksController,
              round: true,
              hintText: remark.tr,
              maxline: 5,
              keyboardtype: TextInputType.text,
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
                      label: controller.balanceB == null ? save.tr : update.tr,
                      onPressed: () {
                        controller.updatebalance();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
