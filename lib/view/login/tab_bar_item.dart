import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/styles/colors/app_colors.dart';
import '../../core/styles/texts/app_text_styles.dart';

class TabBarItem extends StatelessWidget {
  TabBarItem({Key? key, required this.title, required this.isActive,required this.onTap})
      : super(key: key);
  String title;
  bool isActive;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: (isActive)
              ? Border(
                  bottom: BorderSide(color: AppColors.primaryColor, width: 2.h))
              : null),
      child: TextButton(
        onPressed: () {
          onTap();
        },
        child: Text(
          title,
          style: AppTextStyle.bodyText(),
        ),
      ),
    );
  }
}
