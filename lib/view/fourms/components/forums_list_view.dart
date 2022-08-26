import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/cubit/forum/forum_cubit.dart';

import '../../../core/styles/texts/app_text_styles.dart';
import '../../../model/forum/forum_model.dart';
import 'post_item.dart';

class ForumsListView extends StatelessWidget {
  ForumsListView({Key? key, required this.forums}) : super(key: key);
  ForumsModel? forums;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForumCubit,ForumState>(
        listener: (context, state) {},
        builder: (context, state) {
          return (forums == null)
              ? const Center(child: CircularProgressIndicator())
              : (forums!.data!.isEmpty)
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
                          "No posts Found",
                          style: AppTextStyle.title(),
                        ),
                      ],
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => PostItem(
                        forumModel: forums!.data![index],
                        forumKind: 1,
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.h,
                      ),
                      itemCount: forums!.data!.length,
                    );
        });
  }
}
