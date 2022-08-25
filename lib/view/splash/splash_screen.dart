import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/services/local/shared_preference/cache_helper.dart';
import 'package:la_vie/view/login/login_screen.dart';

import '../../core/utils/navigation.dart';
import '../home_layout/home_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Widget destinationScreen;
    if (CacheHelper.getData(key: "accessToken") != null) {
      destinationScreen = HomeLayout();
    } else {
      destinationScreen = LoginScreen();
    }
    Timer(
        const Duration(seconds: 3),
        () => NavigationUtils.navigateAndClearStack(
            context: context, destinationScreen: destinationScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 100.h,
          width: 150.w,
        ),
      ),
    );
  }
}
