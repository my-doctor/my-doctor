import 'package:get/get.dart';
import 'package:mydoctor/controller/bindings/home_binding.dart';
import 'package:mydoctor/controller/bindings/splash_binding.dart';
import 'package:mydoctor/view/screens/auth/login_screen.dart';
import 'package:mydoctor/view/screens/splash_page_view/on_boarding_screen.dart';
import 'package:mydoctor/view/screens/splash_page_view/splash_screen.dart';

import '../controller/bindings/add_doctor_binding.dart';
import '../controller/bindings/auth_binding.dart';
import '../view/screens/auth/forgot_password.dart';
import '../view/screens/auth/patient_register_screen.dart';
import '../view/screens/doctor_screens/add_doctor_info_screen.dart';
import '../view/screens/doctor_screens/doctor_main_screen.dart';
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
        binding: SplashBinding()),
    GetPage(
      name: Routes.confirmOtpScreen,
      page: () => PinCodeVerificationScreen(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => ForgotPassword(),
      binding: AuthBinding()
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 1000),
      binding:AuthBinding()
    ),
    GetPage(
      name: Routes.patientRegisterScreen,
      page: () => PatientRegisterScreen(),
      bindings: [AuthBinding()]
    ),
    GetPage(
      name: Routes.doctorMainScreen,
      page: () => DoctorMainScreen(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 1000),
    ),
    GetPage(
        name: Routes.addDoctorInfoScreen,
        page: () => AddDoctorInfoScreen(),
        bindings: [AddDoctorBinding(), AuthBinding()]),
  ];
}

class Routes {
  static const SplashScreen = "/SplashScreen";
  static const OnBoardingScreen = "/OnBoardingScreen";
  static const loginScreen = "/loginScreen";
  static const confirmOtpScreen = "/confirmOtpScreen";
  static const homeScreen = "/homeScreen";
  static const patientRegisterScreen = "/patientRegisterScreen";
  static const doctorMainScreen = "/doctorMainScreen";
  static const addDoctorInfoScreen = "/addDoctorInfoScreen";
  static const forgotPassword = "/forgotPassword";
}
