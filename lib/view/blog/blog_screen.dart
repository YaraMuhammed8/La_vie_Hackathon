import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/styles/texts/app_text_styles.dart';
import 'package:la_vie/view/blog/components/blog_item.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(
            "Blogs",
            style: AppTextStyle.appBarText(),
          ),
        ),
        Expanded(
          child: ListView.separated(
              padding: EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => BlogItem(),
              separatorBuilder: (context, index) => SizedBox(
                    height: 20.h,
                  ),
              itemCount: 6),
        ),
      ],
    );
  }
}
