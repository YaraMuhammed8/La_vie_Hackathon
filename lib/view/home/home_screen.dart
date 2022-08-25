import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/components/default_text_form_field.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';
import 'package:la_vie/core/utils/navigation.dart';
import 'package:la_vie/cubit/home/home_cubit.dart';
import 'package:la_vie/cubit/quiz/quiz_cubit.dart';
import 'package:la_vie/view/cart/cart_screen.dart';
import 'package:la_vie/view/fourms/fourms_screen.dart';
import 'package:la_vie/view/home/grids/all_grid.dart';
import 'package:la_vie/view/home/grids/plants_grid.dart';
import 'package:la_vie/view/home/grids/seeds_grid.dart';
import 'package:la_vie/view/home/grids/tools_grid.dart';
import 'package:la_vie/view/home/tab_bar_item.dart';

import '../quiz/quiz_screen.dart';
import '../search_product/search_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<String> tabBarItems = ["All", "Plants", "Seeds", "Tools"];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        List<Widget> grids = [
          const AllGrid(),
          const PlantsGrid(),
          const SeedsGrid(),
          const ToolsGrid()
        ];
        return Column(
          children: [
            BlocConsumer<QuizCubit, QuizState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                var cubit = QuizCubit.get(context);
                return AppBar(
                  flexibleSpace: Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 100.h,
                      width: 100.w,
                    ),
                  ),
                  actions: [
                    if (cubit.showQuiz())
                      IconButton(
                          onPressed: () {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: QuizScreen());
                          },
                          icon: const Icon(
                            Icons.lightbulb_outline,
                            color: Colors.amber,
                          )),
                    IconButton(
                      onPressed: () {
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: ForumsScreen());
                      },
                      icon: Icon(
                        Icons.wechat_rounded,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: DefaultTextFormField(
                      textInputType: TextInputType.text,
                      controller: searchController,
                      prefixIcon: Icons.search_rounded,
                      hintText: "Search ...",
                      borderRadius: 10.r,
                      enabledBorderRadius: 10.r,
                      hasBorder: false,
                      isFilled: true,
                      fillColor: Colors.grey.shade100,
                      onTap: () {
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: SearchScreen());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: CartScreen(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.primaryColor,
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 10.w,
                ),
                itemCount: tabBarItems.length,
                itemBuilder: (context, index) => HomeTabBarItem(
                    title: tabBarItems[index],
                    isActive: index == cubit.currentTabBarItem,
                    onTap: () {
                      cubit.changeCurrentTabBarItem(index);
                    }),
              ),
            ),
            Expanded(
              child: grids[cubit.currentTabBarItem],
            )
          ],
        );
      },
    );
  }
}
