import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/modules/aboutus/views/aboutus_view.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/home/widget/Challadialog/lot_add_dialog.dart';
import 'package:pasuhisab/app/modules/home/widget/bottomSheet/balance_widget.dart';
import 'package:pasuhisab/app/modules/home/widget/menu/menu_field.dart';
import 'package:pasuhisab/app/modules/note/bindings/note_binding.dart';
import 'package:pasuhisab/app/modules/note/views/note_view.dart';
import 'package:pasuhisab/app/modules/setting/views/setting_view.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenuHeader extends StatefulWidget {
  const MainMenuHeader({
    Key? key,
  }) : super(key: key);

  @override
  _MainMenuHeaderState createState() => _MainMenuHeaderState();
}

class _MainMenuHeaderState extends State<MainMenuHeader> {
  final packagename = Get.find<SplashController>();

  @override
  void initState() {
    //loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleMenuField(
              text: chick.tr,
              iconData: Icons.add,
              onPressed: () {
                if (controller.isInterstitialAdReady) {
                  controller.interstitialAd?.show();
                }
                Get.bottomSheet(AddLotsWidget(), isDismissible: false);
              },
            ),
            SingleMenuField(
              text: note.tr,
              iconData: Icons.note,
              onPressed: () {
                if (controller.isInterstitialAdReady) {
                  controller.interstitialAd?.show();
                }
                Get.to(NoteView(), binding: NoteBinding());
              },
            ),
            SingleMenuField(
              text: setting.tr,
              iconData: Icons.settings,
              onPressed: () {
                if (controller.isInterstitialAdReady) {
                  controller.interstitialAd?.show();
                }
                Get.to(
                  () => SettingView(),
                );
              },
            ),
            SingleMenuField(
              text: balance.tr,
              iconData: Icons.price_change,
              onPressed: () {
                if (controller.isInterstitialAdReady) {
                  controller.interstitialAd?.show();
                }
                Get.bottomSheet(BalanceWidget());
                //Get.to(() => SettingView(), binding: SettingBinding());
              },
            ),
            SingleMenuField(
              text: sharing.tr,
              iconData: Icons.share,
              onPressed: () {
                try {
                  launch("market://details?id=" +
                      packagename.packageInfo.packageName);
                } on PlatformException catch (e) {
                  launch("https://play.google.com/store/apps/details?id=" +
                      packagename.packageInfo.packageName);
                } finally {
                  launch("https://play.google.com/store/apps/details?id=" +
                      packagename.packageInfo.packageName);
                }
              },
            ),
            SingleMenuField(
              text: about.tr,
              iconData: Icons.business,
              onPressed: () {
                Get.to(AboutusView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
