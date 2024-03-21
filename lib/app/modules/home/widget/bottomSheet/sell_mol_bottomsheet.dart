import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/mol_model.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/controllers/mol_controller.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';
import 'package:pasuhisab/app/modules/utls/validators.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';
import 'package:pasuhisab/app/modules/widgets/button/CustomButton.dart';
import 'package:pasuhisab/app/modules/widgets/input/custome_text_field.dart';

class SellMol extends StatelessWidget {
  const SellMol({
    required this.model,
    this.updated = false,
    Key? key,
  }) : super(key: key);
  final bool updated;
  final MolModel model;

  @override
  Widget build(BuildContext context) {
    // final chick = Get.find<ChicksRecordController>();
    final controller = Get.find<MolController>();
    final hcontroller = Get.find<HomeController>();
    final splash = Get.find<SplashController>();

    if (updated) controller.selectForUpdate(model);
    return BorderContainer(
      widget: SingleChildScrollView(
        child: Form(
          key: controller.formkey,
          child: Column(
            children: [
              Text(
                updated
                    ? selling.tr +
                        ' ' +
                        mol.tr +
                        '(' +
                        date.tr +
                        ' : ${splash.dateNepali.value ? NepaliDateFormat.yMd().format(NepaliDateTime.now()) : DateFormat('yyyy-MM-dd ').format(model.enterdate)})'
                    : selling.tr +
                        ' ' +
                        mol.tr +
                        ' (${splash.dateNepali.value ? NepaliDateFormat.yMd().format(NepaliDateTime.now()) : DateFormat.yMd().format(DateTime.now())})',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.textMultiplier * 1.2,
                ),
              ),
              CustomTextField(
                validator: (value) => validateIsEmpty(string: value),
                controller: controller.boraController,
                round: true,
                hintText: qty.tr + ' ' + bora.tr,
                keyboardtype: TextInputType.number,
                onChange: (value) => controller.calculated(),
              ),
              CustomTextField(
                validator: (value) => validateIsEmpty(string: value),
                controller: controller.amountController,
                round: true,
                hintText: amount.tr,
                keyboardtype: TextInputType.number,
                onChange: (value) => controller.calculated(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: borderRadius / 2,
                  vertical: borderRadius / 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      total.tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Obx(() => Text(
                          rs.tr +
                              controller.totalAmount.value.toString() +
                              '/-',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
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
                          await controller.saveMol(hcontroller.challid.value);
                          await hcontroller.totalIncomeMethod();
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
      ),
    );
  }
}
