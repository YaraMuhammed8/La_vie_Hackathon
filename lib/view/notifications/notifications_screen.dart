import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/styles/texts/app_text_styles.dart';
import 'package:la_vie/view/notifications/components/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(
            "Notifications",
            style: AppTextStyle.appBarText(),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
            child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) => NotificationItem(
            isThereParagraph: false,
          ),
          separatorBuilder: (context, index) => const Divider(),
        )),
      ],
    );
  }
}
