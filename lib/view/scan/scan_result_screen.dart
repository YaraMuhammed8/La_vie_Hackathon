import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/components/default_button.dart';
import 'package:la_vie/core/styles/texts/app_text_styles.dart';
import 'package:la_vie/core/utils/navigation.dart';
import 'package:la_vie/cubit/home/home_cubit.dart';
import 'package:la_vie/view/scan/plant_info_icon.dart';

import '../../core/styles/colors/app_colors.dart';
import '../home_layout/home_layout.dart';

class ScanResultScreen extends StatefulWidget {
  const ScanResultScreen({Key? key}) : super(key: key);

  @override
  State<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  HomeCubit? homeCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeCubit = HomeCubit.get(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homeCubit!.resetScannedResult();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return (cubit.scannedPlant == null)
            ? Container(
                color: AppColors.lightBackGroundColor,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: AppColors.lightBackGroundColor,
                    image: DecorationImage(
                        image: const AssetImage("assets/images/profile_bg.jpg"),
                        fit: BoxFit.cover,
                        onError: (object, trace) => const SizedBox())),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Scaffold(
                    extendBody: true,
                    backgroundColor: Colors.transparent,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        PlantInfoIcon(
                            icon: Icons.wb_sunny_outlined,
                            text: "Sun light",
                            percentage: "${cubit.scannedPlant!.sunLight} %"),
                        PlantInfoIcon(
                            icon: Icons.water_drop_outlined,
                            text: "Water capacity",
                            percentage:
                                "${cubit.scannedPlant!.waterCapacity} %"),
                        PlantInfoIcon(
                            icon: Icons.thermostat_outlined,
                            text: "Temperature",
                            percentage:
                                "${cubit.scannedPlant!.temperature} \xB0c"),
                        SizedBox(
                          height: 40.h,
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.lightBackGroundColor,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.scannedPlant!.name,
                                  style: AppTextStyle.headLine(),
                                ),
                                Text(
                                  "Native to southern Africa, snake plants are well adapted to"
                                  " conditions similar to those in southern regions of the United States."
                                  " Because of this, they may be grown"
                                  " outdoors for part of all of the year in USDA zones 8 and warmer",
                                  style: AppTextStyle.bodyText().copyWith(color: Colors.grey),
                                ),
                                Text(
                                  cubit.scannedPlant!.name,
                                  style: AppTextStyle.headLine(),
                                ),
                                Text(
                                  "A widespread problem with snake plants is root rot."
                                      " This results from over-watering the soil of"
                                      " the plant and is most common in the colder"
                                      " months of the year. ",
                                  style: AppTextStyle.bodyText().copyWith(color: Colors.grey),
                                ),
                                const Spacer(),
                                DefaultButton(
                                    onPress: () {
                                      NavigationUtils.navigateTo(
                                          context: context,
                                          destinationScreen: HomeLayout());
                                    },
                                    borderRadius: 15.r,
                                    text: "Go To Blog")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
      },
    );
  }
}
