import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/modules/dana/controllers/dana_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/category_items.dart';
import 'package:pasuhisab/app/modules/widgets/date_widget.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class DanaAdd extends StatelessWidget {
  const DanaAdd({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DanaController>();
    final chickController = Get.find<HomeController>();
    final splash = Get.find<SplashController>();
    return BorderContainer(
        widget: Form(
      key: controller.formkey,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: SizeConfig.heightMultiplier * 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    dana.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.textMultiplier * 1.2),
                  ),
                  ...danaTypeList.map((e) => Obx(
                        () => controller.selectedDana.value == e.danaType
                            ? InkWell(
                                onTap: () {
                                  controller.selectedDana.value = e.danaType;
                                },
                                child: CategoryItem(
                                  text: e.danaType,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  controller.selectedDana.value = e.danaType;
                                },
                                child: CategoryItem(
                                  text: e.danaType,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                      )),
                ],
              ),
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
            keyboardtype: TextInputType.text,
          ),
          CustomTextField(
            controller: controller.qtyController,
            round: true,
            hintText: qty.tr,
            keyboardtype: TextInputType.number,
            validator: (value) => validateIsEmpty(string: value),
            onChange: (value) => controller.calculateTotal(),
          ),
          CustomTextField(
            onChange: (value) => controller.calculateTotal(),
            validator: (value) => validateIsEmpty(string: value),
            controller: controller.rateController,
            round: true,
            hintText: rate.tr,
            keyboardtype: TextInputType.number,
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier / 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: borderRadius / 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  total.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(() => Text(
                      rs.tr + controller.totalamount.toString() + '/-',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier / 2,
          ),
          Obx(() => CustomButton(
                borderRadius: borderRadius,
                label: controller.updateTable.value ? update.tr : save.tr,
                onPressed: () async {
                  if (controller.updateTable.value) {
                    await controller.updateDana(
                        challid: chickController.challid.value);
                  } else {
                    await controller.addDana(
                        challid: chickController.challid.value);
                  }
                  await controller.getAllDana(chickController.challid.value);
                  await chickController.totalExpenses();
                },
              )),
          SizedBox(
            width: SizeConfig.widthMultiplier / 2,
          ),
        ],
      ),
    ));
  }
}
