import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie/core/components/default_button.dart';
import 'package:la_vie/core/components/default_text_form_field.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';
import 'package:la_vie/core/styles/texts/app_text_styles.dart';

import '../../cubit/forum/forum_cubit.dart';

class CreateNewPostScreen extends StatelessWidget {
  CreateNewPostScreen({Key? key}) : super(key: key);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForumCubit, ForumState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ForumCreatePostSuccessState) {
          Fluttertoast.showToast(
            msg: "Your Post Uploaded Successfully",
            backgroundColor: AppColors.primaryColor,
          );
        } else if (state is ForumCreatePostErrorState) {
          Fluttertoast.showToast(
            msg: "Sorry,an error has occurred while creating post",
            backgroundColor: Colors.black45,
          );
        }
      },
      builder: (context, state) {
        var cubit = ForumCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Create New Post",
              style: AppTextStyle.title(),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(27.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      cubit.pickPostImage();
                    },
                    child: Container(
                      height: 100.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: cubit.uploadedPostImage != null
                          ? Image(
                              image: FileImage(
                                cubit.uploadedPostImage!,
                              ),
                              fit: BoxFit.cover,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: AppColors.primaryColor,
                                ),
                                Text(
                                  "Add Photo",
                                  style: AppTextStyle.bodyText().copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Title",
                      style: AppTextStyle.subTitle(),
                    ),
                  ),
                  DefaultTextFormField(
                    textInputType: TextInputType.text,
                    controller: titleController,
                    required: true,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: AppTextStyle.subTitle(),
                    ),
                  ),
                  DefaultTextFormField(
                    textInputType: TextInputType.text,
                    controller: descriptionController,
                    maxLines: 3,
                    required: true,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  state is ForumCreatePostLoadingState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : DefaultButton(
                          height: 40.h,
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              if (cubit.uploadedPostImage != null) {
                                cubit.createPost(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                );
                                titleController.clear();
                                descriptionController.clear();
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Your have to pick an image..",
                                  backgroundColor: Colors.yellow,
                                );
                              }
                            }
                          },
                          text: "post",
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
