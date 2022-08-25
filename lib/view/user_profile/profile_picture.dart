import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture({Key? key, required this.url}) : super(key: key);
  String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 70.r,
          backgroundColor: Colors.grey.shade100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70.r),
            child: Image.network(
              url,
              errorBuilder: (context, object, trace) => Icon(
                Icons.person,
                size: 70,
                color: Colors.grey.shade300,
              ),
              fit: BoxFit.cover,
              height: 150.w,
              width: 150.w,
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: AppColors.lightBackGroundColor,
              radius: 18.r,
              child: const Icon(
                Icons.edit_outlined,
                color: AppColors.darkPrimaryColor,
              ),
            )),
      ],
    );
  }
}