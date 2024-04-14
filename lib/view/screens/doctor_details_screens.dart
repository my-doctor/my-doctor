import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controllers/home_controller.dart';
import '../../model/user_model.dart';
import '../../utils/constants.dart';
import '../../utils/my_string.dart';
import '../../utils/size_config.dart';
import '../../utils/styles.dart';

import '../widgets/home_widgets/circule_image_avatar.dart';
import '../widgets/home_widgets/reviews_and_sissions_widget.dart';
import '../widgets/utils_widgets/height_size_box.dart';

class DoctorsDetailsScreen extends StatefulWidget {
  DoctorsDetailsScreen({super.key});

  @override
  State<DoctorsDetailsScreen> createState() => _DoctorsDetailsScreenState();
}

class _DoctorsDetailsScreenState extends State<DoctorsDetailsScreen>
    with SingleTickerProviderStateMixin {
  String uid = Get.arguments[0];

  String imageUrlW = Get.arguments[1];

  String name = Get.arguments[2];

  String description = Get.arguments[3];

  UserModel doctorInfo = Get.arguments[4];

  TextEditingController commentController = TextEditingController();

  final homeController = Get.put(HomeScreenController());

  late TabController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      decoration: buildBoxDecoration(context),
                      child: Column(
                        children: [
                          HeightSizeBox(Get.width * .03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.topLeft,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(
                                        IconBroken.Arrow___Left_2,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .color,
                                        size: Get.width * .089,
                                      )),
                                ],
                              ),
                              // SizedBox(
                              //   width: Get.width * .23,
                              // ),
                              Container(
                                  height: Get.width * .25,
                                  width: Get.width * .25,
                                  child: CirculeImageAvatar(
                                    imageUrl: doctorInfo.profileUrl! ?? "",
                                    width: SizeConfig.defaultSize! * 4,
                                  )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width * .089,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          HeightSizeBox(Get.width * .01),
                          Text(
                            "Dr." + name,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          HeightSizeBox(Get.width * .01),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              description,
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          HeightSizeBox(Get.height * .004),

                          GetX<HomeScreenController>(
                            builder: (_) {
                              return ReviewsAndSissions(
                                numOfReviews:
                                    homeController.doctorReviewsList.length ??
                                        0,
                                f1: () {
                                  setState(() {

                                      scrollController.animateTo(0);

                                  });
                                },
                                f2: () {
                                  print("f1 is done");
                                  setState(() {

                                      scrollController.animateTo(1);

                                  });
                                },
                              );
                            },
                          ),
                          HeightSizeBox(Get.height * .015),
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: GetX<HomeScreenController>(
              initState: (_) =>
                  homeController.getDoctorReviews(doctorInfo.phoneNumber!),
              builder: (_) {
                return TabBarView(controller: scrollController, children: [
                  _buildDoctorInfoTab(context),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: homeController.doctorReviewsList.isNotEmpty
                        ? ListView.builder(
                            itemCount: homeController.doctorReviewsList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int i) {
                              return SizedBox(
                                height: Get.height * 0.15,
                                width: Get.width,
                                child: Card(
                                  color: Theme.of(context).cardColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // User Avatar
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundImage: NetworkImage(
                                            userPrImage, // Replace with user avatar URL
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // User Name
                                              Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    homeController
                                                            .doctorReviewsList[
                                                                i]
                                                            .userName ??
                                                        '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: List.generate(
                                                      5,
                                                      (index) => Icon(
                                                        index <
                                                                (homeController
                                                                        .doctorReviewsList[
                                                                            i]
                                                                        .ratingValue ??
                                                                    0)
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: Colors.amber,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              // Comment Text
                                              Text(
                                                homeController
                                                        .doctorReviewsList[i]
                                                        .comment ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                              SizedBox(height: 8),
                                              // Rating Stars
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : SizedBox(
                            child: Center(
                              child: Text(
                                "Theres no Reviews ",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ),
                  ),
                ]);
              },
            ),
          ),
        ),
      ),

      ///                  here the floating action button to add the functionality for(adding review)
      floatingActionButton: homeController.authBox.read("auth") ==
              doctorsCollectionKey
          ? SizedBox()
          : GestureDetector(
              onTap: () {
                Get.defaultDialog(
                    title: "Add Review".tr,
                    content: GetX<HomeScreenController>(
                      builder: (_) {
                        return Container(
                          width: Get.width * .8,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              TextFormField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  hintText: 'Write your review here...'.tr,
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 3,
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  5,
                                  (index) => IconButton(
                                    onPressed: () {
                                      homeController.updateRateValue(index + 1);
                                    },
                                    icon: Icon(
                                      index < homeController.ratingV.value
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 36,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (homeController.ratingV.value == 0) {
                                        Get.snackbar(
                                          "add star",
                                          "please add stars",
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      } else if (commentController
                                              .text.isNotEmpty &&
                                          commentController.text.length > 3) {
                                        homeController.addRatingForDoctor(
                                            doctorInfo.uid!,
                                            homeController.calculateAverageRating(homeController.doctorRatings ),
                                            commentController.text.toString(),
                                            doctorInfo.phoneNumber);
                                      } else {
                                        Get.snackbar(
                                          "Error",
                                          "please enter correct comment",
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      }
                                    },
                                    child: !homeController.isAddingReview.value
                                        ? Text('Add Review'.tr)
                                        : Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: SizedBox(
                                                height: 2,
                                                width: 30,
                                                child:
                                                    LinearProgressIndicator()),
                                          ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('Cancel'.tr),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ));
              },
              child: Container(
                height: Get.height * .06,
                width: Get.width * .6,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: mainColor2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: false
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * .1,
                            vertical: Get.height * .028),
                        child: const LinearProgressIndicator(
                          color: white,
                        ),
                      )
                    : Center(
                        child: Text(
                          "Add review".tr,
                          style: TextStyle(
                              fontSize: 22,
                              color: white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  BoxDecoration buildBoxDecoration(@required context) {
    return BoxDecoration(
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black12.withOpacity(0.5),
      //     spreadRadius: 2,
      //     blurRadius: 6,
      //     offset: Offset(0, 3), // changes position of shadow
      //   ),
      // ],
      // color: Theme.of(context).canvasColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }

  Widget _buildDoctorInfoTab(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doctor Information'.tr,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 20),
            _buildInfoItem('Name'.tr, doctorInfo.displayName ?? '', context),
            _buildInfoItem(
                'Reservation number'.tr, doctorInfo.clinicPhoneNum ?? '', context),
            _buildInfoItem('Bio'.tr, doctorInfo.bio ?? '', context),
            _buildInfoItem('Specialty'.tr, doctorInfo.specialet ?? '', context),
            _buildInfoItem(
                'Clinic Address'.tr, doctorInfo.clinicAddress ?? '', context),
            _buildInfoItem('Available Work Days'.tr,
                orderDaysOfWeek(doctorInfo.availableWorkDays!) ?? '', context),
            _buildInfoItem(
                'Work Start Hour'.tr, doctorInfo.workStartHour ?? '', context),
            _buildInfoItem(
                'Work End Hour'.tr, doctorInfo.workEndHour ?? '', context),
            _buildInfoItem('Notes'.tr, doctorInfo.notes ?? '', context),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
  String orderDaysOfWeek(String daysString) {
    List<String> daysList = daysString.split(', '); // Split by comma and space

    // Define the order of days in a week
    List<String> weekDaysOrder = [
      'السبت',
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة'
    ];

    // Sort the days based on their order in a week
    daysList.sort((a, b) => weekDaysOrder.indexOf(a).compareTo(weekDaysOrder.indexOf(b)));

    // Join the sorted days back into a string
    String sortedDaysString = daysList.join(', ');

    return sortedDaysString;
  }
  Widget _buildInfoItem(String label, String value, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headline4,
        ),
        Divider(color: Colors.grey[300]),
        SizedBox(height: 16),
      ],
    );
  }
}
