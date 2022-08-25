import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/cubit/home/home_cubit.dart';

import '../../core/components/default_text_form_field.dart';
import '../../core/styles/texts/app_text_styles.dart';
import '../../model/home/plants.dart';
import '../../model/home/tools.dart';
import '../home/grid_item_types/plant_item.dart';
import '../home/grid_item_types/seed_item.dart';
import '../home/grid_item_types/tool_item.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    BlocProvider.of<HomeCubit>(context).clearSearchResult();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
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
                  suffixIcon: Icons.filter_list,
                  onChange: (value) {
                    cubit.searchProducts(searchController.text);
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                if (cubit.searchedProducts != null)
                  (cubit.searchedProducts!.isEmpty)
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.h,
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
                            "No Product found",
                            style: AppTextStyle.bodyText(),
                          )
                        ],
                      )
                      : Expanded(
                          child: GridView.count(
                              crossAxisCount: 2,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(10),
                              childAspectRatio: 1.w / 1.51.h,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 20.h,
                              children: cubit.searchedProducts!.map((e) {
                                if (e is Plant) {
                                  return PlantItem(plant: e);
                                } else if (e is Tool) {
                                  return ToolItem(tool: e);
                                } else {
                                  return SeedItem(seed: e);
                                }
                              }).toList()))
              ],
            ),
          ),
        );
      },
    );
  }
}
