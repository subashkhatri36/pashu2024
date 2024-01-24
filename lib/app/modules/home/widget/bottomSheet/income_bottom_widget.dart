import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/egg_model.dart';
import 'package:pasuhisab/app/data/model/mol_model.dart';
import 'package:pasuhisab/app/data/model/other.dart';
import 'package:pasuhisab/app/modules/chickensell/bindings/chickensell_binding.dart';
import 'package:pasuhisab/app/modules/chickensell/views/chickensell_view.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/egg_sell_bottomsheet.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/other_income_bottomsheet.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/sell_mol_bottomsheet.dart';
import 'package:pasuhisab/app/modules/home/widget/menu/sub_menu_click_menu.dart';
import 'package:pasuhisab/app/modules/widgets/border_container.dart';

class BottomIncomeWidget extends StatelessWidget {
  const BottomIncomeWidget({
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
            color: Colors.green,
            width: MediaQuery.of(context).size.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Text(
                    add.tr + ' ' + income.tr,
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
              if (controller.isInterstitialAdReady) {
                controller.interstitialAd?.show();
              }
              navigator?.pop();
              Get.to(ChickensellView(), binding: ChickensellBinding());
            },
            text: chicken.tr + ' ' + selling.tr,
          ),
          ClickMenu(
            onPressed: () {
              if (controller.isInterstitialAdReady) {
                controller.interstitialAd?.show();
              }
              navigator?.pop();
              Get.bottomSheet(SellMol(
                model: MolModel(
                  qty: 0,
                  rate: 0,
                  challid: 0,
                  enterdate: DateTime.now(),
                ),
              ));
            },
            text: mol.tr + ' ' + selling.tr,
          ),
          ClickMenu(
            onPressed: () {
              if (controller.isInterstitialAdReady) {
                controller.interstitialAd?.show();
              }
              navigator?.pop();
              Get.bottomSheet(
                EggSell(
                  model: EggModel(
                      qty: 0, rate: 0, challid: 0, enterdate: DateTime.now()),
                ),
              );
            },
            text: egg.tr + ' ' + selling.tr,
          ),
          ClickMenu(
            onPressed: () {
              if (controller.isInterstitialAdReady) {
                controller.interstitialAd?.show();
              }
              navigator?.pop();
              Get.bottomSheet(OtherIncome(
                inout: true,
                updateed: false,
                model: OtherModel(
                  challid: 0,
                  inout: false,
                  total: 0,
                  remarks: '',
                  enterdate: DateTime.now(),
                ),
              ));
            },
            text: other.tr + ' ' + selling.tr,
          ),
        ],
      ),
    ));
  }
}
