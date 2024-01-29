import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/view/screens/doctors_screen.dart';

import '../../utils/constants.dart';
import '../widgets/home_widgets/medical_specialt_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MedicalSpecialties extends StatelessWidget {
  MedicalSpecialties({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         shadowColor: Colors.black,
        elevation: 2,
        title: Text(
          "Medical Specialties".tr,
         ),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: Get.locale?.languageCode == "ar"
            ? medicalSpecialtiesAr.length
            : medicalSpecialtiesEn.length,
        itemBuilder: (BuildContext context, int index) {

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: 500),
            child: SlideAnimation(
              horizontalOffset: 100,
              child: FadeInAnimation(
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => DoctorsBySpecialtiesScreen(
                          specialties: Get.locale?.languageCode == "ar"
                              ? medicalSpecialtiesAr[index]['name']!
                              : medicalSpecialtiesEn[index]['name']!),
                      transition: Transition.rightToLeft,
                      //    duration: Duration(seconds: 1)
                    );
                  },
                  child: CustomListTile(
                    title: Get.locale?.languageCode == "ar"
                        ? medicalSpecialtiesAr[index]['name']!
                        : medicalSpecialtiesEn[index]['name']!,
                    description: Get.locale?.languageCode == "ar"
                        ? medicalSpecialtiesAr[index]['description']!
                        : medicalSpecialtiesEn[index]['description']!,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Map<String, String>> medicalSpecialtiesEn = [
  {
    'name': 'Family Medicine',
    'description':
        'Comprehensive healthcare for individuals and families throughout life.',
  },
  {
    'name': 'General Surgery',
    'description': 'Specializes in performing general surgical procedures.',
  },
  {
    'name': 'Pediatrics',
    'description': 'Specialized healthcare for children and adolescents.',
  },
  {
    'name': 'Cardiology',
    'description': 'Diagnosis and treatment of heart and vascular diseases.',
  },
  {
    'name': 'Respiratory Medicine',
    'description':
        'Diagnosis and treatment of respiratory system diseases such as asthma and pneumonia.',
  },
  {
    'name': 'Obstetrics and Gynecology',
    'description': 'Women’s healthcare and pregnancy monitoring and delivery.',
  },
  {
    'name': 'Ophthalmology',
    'description': 'Diagnosis and treatment of eye and vision problems.',
  },
  {
    'name': 'Dermatology',
    'description':
        'Diagnosis and treatment of skin diseases and related conditions.',
  },
  {
    'name': 'Dentistry',
    'description': 'Dental, jaw, and gum care.',
  },
  {
    'name': 'Psychiatry',
    'description':
        'Diagnosis and treatment of mental and psychological disorders.',
  },
];

List<Map<String, String>> medicalSpecialtiesAr = [
  {
    'name': 'طب الأسرة',
    'description': 'الرعاية الصحية الشاملة للأفراد والعائلات على مدار الحياة.',
  },
  {
    'name': 'الجراحة العامة',
    'description': 'التخصص في إجراء العمليات الجراحية العامة.',
  },
  {
    'name': 'طب الأطفال',
    'description': 'الرعاية الصحية المتخصصة للأطفال والمراهقين.',
  },
  {
    'name': 'أمراض القلب والأوعية الدموية',
    'description': 'تشخيص وعلاج أمراض القلب والأوعية الدموية.',
  },
  {
    'name': 'أمراض الجهاز التنفسي',
    'description':
        'تشخيص وعلاج أمراض الجهاز التنفسي مثل الربو والالتهاب الرئوي.',
  },
  {
    'name': 'طب النساء والتوليد',
    'description': 'الرعاية الصحية للنساء ومتابعة الحمل والولادة.',
  },
  {
    'name': 'طب العيون',
    'description': 'تشخيص وعلاج أمراض ومشاكل العيون.',
  },
  {
    'name': 'طب الأمراض الجلدية',
    'description': 'تشخيص وعلاج أمراض الجلد والأمراض المتعلقة بالبشرة.',
  },
  {
    'name': 'طب الأسنان',
    'description': 'العناية بالأسنان والفكين واللثة.',
  },
  {
    'name': 'الطب النفسي',
    'description': 'تشخيص وعلاج الاضطرابات النفسية والعقلية.',
  },
];
