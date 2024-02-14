import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../../utils/styles.dart';
import '../utils_widgets/text_utils.dart';

class ReviewsAndSissions extends StatelessWidget {
  int numOfReviews;

  ReviewsAndSissions({Key? key,required this.numOfReviews})  ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.defaultSize! * 2,
      width: SizeConfig.screenWidth!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  IconBroken.Profile,
                  color: Colors.blue,
                  size: SizeConfig.defaultSize! * 1.2,
                ),
             Text(" details",style: Theme.of(context).textTheme.headline4,)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_rate_outlined,
                  color: Colors.yellow,
                  size: SizeConfig.defaultSize! * 1.2,
                ),
                Text(" ${numOfReviews??0}",style: Theme.of(context).textTheme.headline4,),
                 Text("  reviews" ,style: Theme.of(context).textTheme.headline4,)


              ],
            ),
          ],
        ),
      ),
    );
  }
}
