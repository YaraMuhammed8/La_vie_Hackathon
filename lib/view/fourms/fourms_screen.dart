import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/components/default_text_form_field.dart';
import 'package:la_vie/core/utils/navigation.dart';
import 'package:la_vie/view/home/components/tab_bar_item.dart';

import '../../cubit/forum/forum_cubit.dart';
import 'components/forums_list_view.dart';
import 'create_new_post_screen.dart';

class ForumsScreen extends StatefulWidget {
  const ForumsScreen({Key? key}) : super(key: key);

  @override
  State<ForumsScreen> createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {
  final List<String> tabBarItems = ["All Forums", "My forums"];

  final TextEditingController searchController = TextEditingController();

  List<Widget> forumsLists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ForumCubit.get(context)
      ..getAllForums()
      ..getMyForums();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForumCubit, ForumState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ForumCubit.get(context);
        forumsLists = [
          ForumsListView(forums: ForumCubit.get(context).allForumModel),
          ForumsListView(forums: ForumCubit.get(context).myForumModel),
        ];
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                DefaultTextFormField(
                  textInputType: TextInputType.text,
                  controller: searchController,
                  prefixIcon: Icons.search_rounded,
                  hintText: "Search ...",
                  borderRadius: 10.r,
                  enabledBorderRadius: 10.r,
                  hasBorder: false,
                  isFilled: true,
                  fillColor: Colors.grey.shade100,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    tabBarItems.length,
                    (index) => HomeTabBarItem(
                        title: tabBarItems[index],
                        isActive: index == cubit.currentTabBarItem,
                        onTap: () {
                          cubit.changeCurrentTabBarItem(index);
                        }),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: forumsLists[cubit.currentTabBarItem],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              NavigationUtils.navigateTo(
                context: context,
                destinationScreen: CreateNewPostScreen(),
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
