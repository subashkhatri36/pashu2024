import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';
import 'package:pasuhisab/app/constants/themes.dart';
import 'package:pasuhisab/app/constants/translate.dart';

import 'app/routes/app_pages.dart';
import 'inital_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        final lan = Locale('en', 'US');
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: TLanguage(),
          locale: lan, //need to change it too
          fallbackLocale: lan,
          title: appName,
          theme: Themes.light,
          darkTheme: Themes.dark,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          defaultTransition: Transition.native,
          builder: EasyLoading.init(),
          initialBinding: InitialBinding(),
        );
      });
    });
  }
}
