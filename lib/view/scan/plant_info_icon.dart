import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/styles/texts/app_text_styles.dart';

class PlantInfoIcon extends StatelessWidget {
  PlantInfoIcon(
      {Key? key,
      required this.icon,
      required this.text,
      required this.percentage})
      : super(key: key);
  IconData icon;
  String text;
  String percentage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.black45,
            ),
            child: Icon(icon,color: Colors.grey.shade300,)),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              percentage,
              style: AppTextStyle.title().copyWith(color: Colors.white),
            ),
            Text(
              text,
              style: AppTextStyle.bodyText().copyWith(color: Colors.white),
            ),
          ],
        )
      ],
    );
  }
}
