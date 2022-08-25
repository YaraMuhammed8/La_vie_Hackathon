import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie/core/components/default_text_form_field.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';
import 'package:la_vie/core/styles/texts/app_text_styles.dart';
import 'package:la_vie/cubit/forum/forum_cubit.dart';
import 'package:la_vie/model/forum/forum_model.dart';

class ForumCommentsScreen extends StatelessWidget {
  final List<ForumComments> comments;
  String forumId;
  int forumKind;
  TextEditingController commentController = TextEditingController();
  ForumCommentsScreen(
      {super.key,
      required this.comments,
      required this.forumId,
      required this.forumKind});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForumCubit, ForumState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CommentOnForumSuccessfulState) {
          Fluttertoast.showToast(
            msg: "Comment posted Successfully",
            backgroundColor: Colors.black54,
          );
        } else if (state is CommentOnForumErrorState) {
          Fluttertoast.showToast(
            msg: "Sorry, an error has occurred while posting comment",
            backgroundColor: Colors.black54,
          );
        }
      },
      builder: (context, state) {
        var cubit = ForumCubit.get(context);
        return AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Comments",
                    style: AppTextStyle.headLine(),
                  ),
                  if (comments.isEmpty) ...[
                    Text(
                      "No comments yet..",
                      style: AppTextStyle.subTitle(),
                    ),
                    const Spacer(),
                  ] else
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) => ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comments[index].userId.toString(),
                                      style: AppTextStyle.title(),
                                    ),
                                    Text(
                                      comments[index].createdAt.toString(),
                                      style: AppTextStyle.subTitle().copyWith(
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  comments[index].comment.toString(),
                                  style: AppTextStyle.subTitle(),
                                ),
                              ),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: comments.length),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DefaultTextFormField(
                            textInputType: TextInputType.text,
                            controller: commentController,
                            isFilled: true,
                            hasBorder: false,
                            hintText: "write comment",
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              if (commentController.text.isNotEmpty) {
                                cubit.sendCommentOnForum(forumId, forumKind,
                                    comment: commentController.text);
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              }
                            },
                            child: Text(
                              "Post",
                              style: AppTextStyle.bodyText()
                                  .copyWith(color: AppColors.primaryColor),
                            ))
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
