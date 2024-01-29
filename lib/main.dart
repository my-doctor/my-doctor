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
  // WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
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
      locale: Locale(GetStorage().read<String>('lang').toString()),
      translations: LocaliztionApp(),
      fallbackLocale: Locale(ene),
      title: 'Flutter Demo',
      theme: ThemesApp.light,
      darkTheme: ThemesApp.dark,
      themeMode: ThemeController().themeDataGet,
      initialRoute:

      Routes.loginScreen,
      getPages: AppRoutes.routes,

     );
  }
}
