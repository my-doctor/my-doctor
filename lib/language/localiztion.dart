import 'package:get/route_manager.dart';
import 'package:mydoctor/language/ar.dart';

import '../utils/my_string.dart';
import '../view/screens/medical_specialties.dart';
import 'en.dart';

class LocaliztionApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ene: en,
        ara: ar,

       };

}
