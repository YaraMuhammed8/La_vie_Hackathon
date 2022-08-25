import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';
import 'package:la_vie/core/styles/texts/app_text_styles.dart';
import 'package:la_vie/model/forum/forum_model.dart';

import '../../../cubit/forum/forum_cubit.dart';
import '../forum_comments_screen.dart';

class PostItem extends StatelessWidget {
  final Data forumModel;
  final int forumKind;
  const PostItem({
    super.key,
    required this.forumModel,
    required this.forumKind,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForumCubit, ForumState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ForumCubit.get(context);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(forumModel.user!.imageUrl!),
                ),
                title: Text(
                  "${forumModel.user!.firstName} ${forumModel.user!.lastName}",
                  style: AppTextStyle.bodyText(),
                ),
                subtitle: Text(
                  "a month ago",
                  style: AppTextStyle.subTitle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${forumModel.title}",
                      style: AppTextStyle.title().copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      "${forumModel.description}",
                      style: AppTextStyle.subTitle(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image(
                        image: NetworkImage(
                          'https://lavie.orangedigitalcenteregypt.com${forumModel.imageUrl!}',
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            cubit.likeForum(forumModel.forumId!, forumKind);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              (cubit.isUserLiked(forumModel.forumLikes!))
                                  ? Icon(Icons.favorite_rounded,
                                      color: AppColors.primaryColor)
                                  : Icon(Icons.favorite_border_rounded,
                                      color: Colors.grey),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "${forumModel.forumLikes!.length} Likes",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                builder: (context) => ForumCommentsScreen(
                                      comments: forumModel.forumComments ?? [],
                                      forumId: forumModel.forumId!,
                                      forumKind: forumKind,
                                    ));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                  "${forumModel.forumComments!.length} Comments",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
