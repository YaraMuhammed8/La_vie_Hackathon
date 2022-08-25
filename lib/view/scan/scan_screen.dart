import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/cubit/home/home_cubit.dart';
import 'package:la_vie/view/scan/scan_result_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/utils/navigation.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              MobileScanner(
                  allowDuplicates: false,
                  controller: MobileScannerController(
                    facing: CameraFacing.back,
                    torchEnabled: false,
                  ),
                  onDetect: (barcode, args) {
                    if (barcode.rawValue == null) {
                      debugPrint('Failed to scan Barcode');
                    } else {
                      final String code = barcode.rawValue!;
                      debugPrint(
                          "**************************************************************"
                          "***********************************************************************");
                      debugPrint('Barcode found! $code');
                      cubit.getPlantDetails(code);
                      NavigationUtils.navigateAndClearStack(
                          context: context,
                          destinationScreen: ScanResultScreen());
                    }
                  }),
              SvgPicture.asset(
                "assets/images/scanner1.svg",
                color: Colors.white.withOpacity(0.7),
              )
            ],
          ),
        );
      },
    );
  }
}
