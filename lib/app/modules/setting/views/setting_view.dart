import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/constant.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/data/model/settings.dart';
import 'package:pasuhisab/app/modules/home/controllers/home_controller.dart';
import 'package:pasuhisab/app/modules/splash/controllers/splash_controller.dart';

class SettingView extends StatelessWidget {
  //final splash= Get.put(() => SplashController(),);
  final splash = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    // splash.loadsetting();

    return Scaffold(
        appBar: AppBar(
          title: Text(setting.tr),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageSetting.tr,
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.2,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  //Theme
                  Expanded(
                    child: Obx(() => BorderWidget(
                          text: english.tr,
                          language: true,
                          sel: splash.nepaliLanguage.value == true
                              ? false
                              : true,
                        )),
                  ),
                  Expanded(
                    child: Obx(() => BorderWidget(
                          text: nepali.tr,
                          language: true,
                          sel: splash.nepaliLanguage.value == true
                              ? true
                              : false,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date.tr + ' ' + setting.tr,
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 1.2,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  //Theme
                  Expanded(
                    child: Obx(() => BorderWidget(
                          text: english.tr,
                          sel: splash.dateNepali.value == true ? false : true,
                        )),
                  ),
                  Expanded(
                    child: Obx(() => BorderWidget(
                          text: nepali.tr,
                          sel: splash.dateNepali.value == true ? true : false,
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class BorderWidget extends StatelessWidget {
  const BorderWidget(
      {Key? key, required this.text, this.language = false, this.sel = false})
      : super(key: key);
  final String text;
  final bool language;
  final bool sel;

  @override
  Widget build(BuildContext context) {
    final splash = Get.find<SplashController>();
    final contr = Get.find<HomeController>();

    return InkWell(
      onTap: () {
        if (language) {
          if (text == english.tr) {
            splash.nepaliLanguage.value = false;
          } else {
            splash.nepaliLanguage.value = true;
          }
        } else {
          if (text == english.tr) {
            splash.dateNepali.value = false;
          } else {
            splash.dateNepali.value = true;
          }
        }
        Settings s = new Settings(
            id: splash.id.value,
            datetypeNepali: splash.dateNepali.value,
            languageNepali: splash.nepaliLanguage.value,
            themelight: splash.lighTheme.value,
            autobackup: true);

        splash.updatesetting(s);
        contr.loadingChicks();
      },
      child: Container(
        decoration: BoxDecoration(
            color: sel ? Theme.of(context).backgroundColor : Colors.transparent,
            border: Border.all(
              color: sel ? Theme.of(context).backgroundColor : Colors.black,
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius / 4))),
        margin: EdgeInsets.all(borderRadius / 2),
        padding: EdgeInsets.all(borderRadius / 2),
        child: Text(
          text,
          style: TextStyle(color: sel ? Colors.white : Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
