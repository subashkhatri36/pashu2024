import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:pasuhisab/app/constants/themes.dart';
import 'package:pasuhisab/app/core/repositories/setting_repositories.dart';
import 'package:pasuhisab/app/data/model/settings.dart';
import 'package:pasuhisab/app/modules/home/bindings/home_binding.dart';
import 'package:pasuhisab/app/modules/home/views/home_view.dart';

class SplashController extends GetxController {
  SettingsRepo settingsRepo = new SettingsRepositories();
  RxBool nepaliLanguage = false.obs;
  RxBool lighTheme = true.obs;
  RxBool dateNepali = false.obs;
  RxInt id = 0.obs;

  @override
  void onInit() {
    loadPage();
    loading();
    super.onInit();
  }

  loadsetting() async {
    Settings setting = await settingsRepo.getSettings();
    if (setting != null) {
      nepaliLanguage.value = setting.languageNepali;
      lighTheme.value = setting.themelight;
      dateNepali.value = setting.datetypeNepali;
      id.value = setting.id;
      loadLanguage();
    }
  }

  late PackageInfo packageInfo; // await PackageInfo.fromPlatform();

  void loading() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  updatesetting(Settings setting) async {
    int res = await settingsRepo.updateSettings(setting);
    if (res > 0) {
      nepaliLanguage.value = setting.languageNepali;
      lighTheme.value = setting.themelight;
      dateNepali.value = setting.datetypeNepali;

      loadTheme();
      loadLanguage();
    }
  }

  loadPage() async {
    await loadsetting();

    var _duration = Duration(seconds: 1);
    return Timer(_duration, navigate);
  }

  void loadTheme() {
    if (lighTheme.isTrue)
      Get.changeTheme(Themes.light);
    else
      Get.changeTheme(Themes.dark);
  }

  void loadLanguage() {
    if (nepaliLanguage.value)
      changeLanugage('ne', 'NP');
    else
      changeLanugage('en', 'US');
  }

  void changeLanugage(String par1, String par2) {
    var local = Locale(par1, par2);
    Get.updateLocale(local);
  }

  void navigate() {
    Get.off(() => HomeView(), binding: HomeBinding());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
