import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/styles/texts/app_text_styles.dart';
import '../../cubit/forumn/forum_cubit.dart';
import 'components/post_item.dart';

class AllForumsView extends StatelessWidget {
  const AllForumsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForumCubit, ForumState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ForumCubit.get(context);
        return cubit.allForumModel == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35.h,
                  ),
                  Image(
                    image: const AssetImage(
                      "assets/images/not-found.png",
                    ),
                    fit: BoxFit.cover,
                    height: 200.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "No Forms Posted Yet..",
                    style: AppTextStyle.title(),
                  ),
                ],
              )
            : ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => PostItem(
                  forumModel: cubit.allForumModel!.data![index],
                  forumKind: 0,
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 15.h,
                ),
                itemCount: 10,
              );
      },
    );
  }
}
