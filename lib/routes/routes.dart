import 'package:get/get.dart';
import 'package:mydoctor/controller/bindings/home_binding.dart';
import 'package:mydoctor/controller/bindings/splash_binding.dart';
import 'package:mydoctor/view/screens/auth/login_screen.dart';
import 'package:mydoctor/view/screens/splash_page_view/on_boarding_screen.dart';
import 'package:mydoctor/view/screens/splash_page_view/splash_screen.dart';

import '../view/screens/home_screen.dart';
import '../view/widgets/auth/pin_put_widget.dart';

class AppRoutes {
  static final routes = [
    GetPage(
        name: Routes.SplashScreen,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.OnBoardingScreen,
        page: () => OnBoardingScreen(),
        binding: SplashBinding()),    GetPage(
        name: Routes.confirmOtpScreen,
        page: () => PinCodeVerificationScreen(),
         ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 1000),

    ),    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 1000),

    ),
  ];
}

class Routes {
  static const SplashScreen = "/SplashScreen";
  static const OnBoardingScreen = "/OnBoardingScreen";
  static const loginScreen = "/loginScreen";
  static const confirmOtpScreen = "/confirmOtpScreen";
  static const homeScreen = "/homeScreen";
}
