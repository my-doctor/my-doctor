import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/view/screens/doctors_screen.dart';

import '../../utils/constants.dart';
import '../widgets/home_widgets/medical_specialt_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MedicalSpecialties extends StatelessWidget {
  MedicalSpecialties({super.key});
  List<Map<String, String>> medicalSpecialtiesEn = [
    {
      'name': 'Cardiology',
      'description': 'Deals with disorders of the heart and circulatory system.',
    },
    {
      'name': 'Dermatology',
      'description': 'Focuses on the skin, hair, and nails, and their diseases.',
    },
    {
      'name': 'Orthopedics',
      'description': 'Specializes in conditions involving the musculoskeletal system.',
    },
    {
      'name': 'Neurology',
      'description': 'Deals with disorders of the nervous system, including the brain and spinal cord.',
    },
    {
      'name': 'Ophthalmology',
      'description': 'Specializes in eye and vision care.',
    },
    {
      'name': 'Pediatrics',
      'description': 'Focuses on the health and medical care of infants, children, and adolescents.',
    },
    {
      'name': 'Psychiatry',
      'description': 'Deals with the diagnosis, treatment, and prevention of mental illnesses.',
    },
    {
      'name': 'Surgery',
      'description': 'Covers a broad range of procedures that involve manual or instrumental techniques.',
    },
    // Add more specialties as needed
  ];

  List<Map<String, String>> medicalSpecialtiesAr = [
    {
      'name': 'طب الأسرة',
      'description':
          'الرعاية الصحية الشاملة للأفراد والعائلات على مدار الحياة.',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: homeBackGroundColor,
        shadowColor: Colors.black,
        elevation: 2,
        title: Text(
          "التخصصات الطبيه",
          style: TextStyle(fontWeight: FontWeight.w800, fontFamily: "Cairo"),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: medicalSpecialtiesAr.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(seconds: 1),
            child: SlideAnimation(
              horizontalOffset: 100,
              child: FadeInAnimation(
                child: InkWell(
                  onTap: () {
                    Get.to(
                        () => DoctorsBySpecialtiesScreen(
                            specialties: medicalSpecialtiesAr[index]['name']!),
                        transition: Transition.rightToLeft,
                    //    duration: Duration(seconds: 1)
                    );
                  },
                  child: CustomListTile(
                    title: medicalSpecialtiesAr[index]['name']!,
                    description: medicalSpecialtiesAr[index]['description']!,
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
