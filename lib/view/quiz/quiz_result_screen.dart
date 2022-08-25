import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';
import 'package:la_vie/core/styles/texts/app_text_styles.dart';

class QuizResultScreen extends StatelessWidget {
  QuizResultScreen({Key? key, required this.result}) : super(key: key);
  int result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          "Result",
          style: AppTextStyle.appBarText(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Result is",
              style: AppTextStyle.headLine().copyWith(fontSize: 30),
            ),
            SizedBox(height: 10.h,),
            Text(
              result.toString(),
              style:
                  AppTextStyle.headLine().copyWith(color: AppColors.primaryColor,fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
