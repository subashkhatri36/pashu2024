import 'package:get/get.dart';

import 'package:pasuhisab/app/modules/aboutus/bindings/aboutus_binding.dart';
import 'package:pasuhisab/app/modules/aboutus/views/aboutus_view.dart';
import 'package:pasuhisab/app/modules/addnote/bindings/addnote_binding.dart';
import 'package:pasuhisab/app/modules/addnote/views/addnote_view.dart';
import 'package:pasuhisab/app/modules/addselling/bindings/addselling_binding.dart';
import 'package:pasuhisab/app/modules/addselling/views/addselling_view.dart';
import 'package:pasuhisab/app/modules/chickensell/bindings/chickensell_binding.dart';
import 'package:pasuhisab/app/modules/chickensell/views/chickensell_view.dart';
import 'package:pasuhisab/app/modules/chickensellreport/bindings/chickensellreport_binding.dart';
import 'package:pasuhisab/app/modules/chickensellreport/views/chickensellreport_view.dart';
import 'package:pasuhisab/app/modules/dana/bindings/dana_binding.dart';
import 'package:pasuhisab/app/modules/dana/views/dana_view.dart';
import 'package:pasuhisab/app/modules/dannaconsumption/bindings/dannaconsumption_binding.dart';
import 'package:pasuhisab/app/modules/dannaconsumption/views/dannaconsumption_view.dart';
import 'package:pasuhisab/app/modules/home/bindings/home_binding.dart';
import 'package:pasuhisab/app/modules/home/views/home_view.dart';
import 'package:pasuhisab/app/modules/note/bindings/note_binding.dart';
import 'package:pasuhisab/app/modules/note/views/note_view.dart';
import 'package:pasuhisab/app/modules/setting/bindings/setting_binding.dart';
import 'package:pasuhisab/app/modules/setting/views/setting_view.dart';
import 'package:pasuhisab/app/modules/splash/bindings/splash_binding.dart';
import 'package:pasuhisab/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.DANA,
      page: () => DanaView(),
      binding: DanaBinding(),
    ),
    GetPage(
      name: _Paths.CHICKENSELL,
      page: () => ChickensellView(),
      binding: ChickensellBinding(),
    ),
    GetPage(
      name: _Paths.CHICKENSELLREPORT,
      page: () => ChickensellreportView(),
      binding: ChickensellreportBinding(),
    ),
    GetPage(
      name: _Paths.DANNACONSUMPTION,
      page: () => DannaconsumptionView(),
      binding: DannaconsumptionBinding(),
    ),
    GetPage(
      name: _Paths.NOTE,
      page: () => NoteView(),
      binding: NoteBinding(),
    ),
    GetPage(
      name: _Paths.ADDNOTE,
      page: () => AddnoteView(),
      binding: AddnoteBinding(),
    ),
    GetPage(
      name: _Paths.ADDSELLING,
      page: () => AddsellingView(),
      binding: AddsellingBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTUS,
      page: () => AboutusView(),
      binding: AboutusBinding(),
    ),
  ];
}
