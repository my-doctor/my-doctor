import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:mydoctor/routes/routes.dart';
import 'package:mydoctor/utils/constants.dart';
import 'package:mydoctor/utils/my_string.dart';

import 'controller/controllers/theme_controller.dart';
import 'language/localiztion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(GetStorage().read<String>('lang').toString()??ara),
      translations: LocaliztionApp(),
      fallbackLocale: Locale(ara),
      title: 'myDoctor ',
      theme: ThemesApp.light,
      darkTheme: ThemesApp.dark,
      themeMode: ThemeController().themeDataGet,
      initialRoute:GetStorage().read("auth") == patientsCollectionKey
          ? Routes.homeScreen
          : GetStorage().read("auth") == doctorsCollectionKey
          ? Routes.homeScreen
          :  Routes.loginScreen,
      getPages: AppRoutes.routes,
    );
  }
}
/*
Variant: debug
Config: debug
Store: C:\Users\Levi\.android\debug.keystore
Alias: AndroidDebugKey
MD5: CF:DC:41:EA:A5:3E:80:DD:C4:62:96:18:30:D2:17:3D
SHA1: 59:FA:16:DA:36:EA:E8:AE:7A:E6:FF:80:39:11:E2:F9:1E:89:3C:25
SHA-256: BC:19:A0:6B:C4:CE:61:8B:25:B8:E4:7F:F4:D6:34:8D:09:41:85:F7:66:A9:0F:8A:C3:38:86:78:D1:B2:C8:BF
Valid until: Tuesday, December 19, 2051

 */