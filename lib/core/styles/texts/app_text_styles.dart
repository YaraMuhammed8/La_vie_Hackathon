import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle headLine() => TextStyle(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: "Cairo",
  );

  static TextStyle appBarText() => TextStyle(
    color: Colors.black,
    fontSize: 20.0.sp,
    fontWeight: FontWeight.bold,
    fontFamily: "Cairo",
  );
  static TextStyle title() => TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: "Cairo",
    height: 1.2.h,
  );
  static TextStyle bodyText() => TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: "Cairo",
  );
  static TextStyle subTitle() => TextStyle(
    fontSize: 14.0.sp,
    color: Colors.grey,
    height: 1.1.h,
    fontFamily: "Cairo",
  );
}