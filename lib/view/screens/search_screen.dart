import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/view/widgets/utils_widgets/search_widget.dart';

import '../../controller/controllers/home_controller.dart';
import '../../utils/constants.dart';
import '../widgets/home_widgets/doctor_card.dart';

class SearchScreen extends StatelessWidget {
  // final homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 2,
        title: Text(
          "Search".tr,
        ),
        centerTitle: true,
      ),
      body: GetX(
        builder: (HomeScreenController homeController) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: TextFormField(style: Theme.of(context).textTheme.headline4,
                        onChanged: (value) {
                          homeController.addSearchToList(value);
                        },
                        controller: homeController.search,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              homeController.addSearchToList(
                                homeController.search.text,
                              );
                              //////////////
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: "Search ...".tr,
                          hintStyle: TextStyle(
                            color: grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey ,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: mainColor2,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'search must not be null';
                          }
                          return null;
                        },
                        onFieldSubmitted: (val) {
                          ////////////////////////
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      child: //controller.searchList.isNotEmpty ||
                          homeController.isSearching.value == true
                              ? ListView.builder(
                                  itemCount: homeController.searchList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return DoctorCard(
                                        name: homeController
                                            .searchList[index].displayName!,
                                        description: homeController
                                            .searchList[index].bio!,
                                        imageUrl: homeController
                                            .searchList[index].profileUrl!,
                                        uid: homeController
                                            .searchList[index].uid!,
                                        doctorInfo:
                                            homeController.searchList[index]);
                                  },
                                )
                              : Center(
                                  child: Text(
                                    "enter doctor name to search".tr,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                )),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
