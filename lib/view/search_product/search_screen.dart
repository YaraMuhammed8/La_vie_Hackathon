import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/components/default_text_form_field.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultTextFormField(
            textInputType: TextInputType.text,
            controller: searchController,
            prefixIcon: Icons.search_rounded,
            hintText: "Search ...",
            borderRadius: 10.r,
            enabledBorderRadius: 10.r,
            hasBorder: false,
            isFilled: true,
            fillColor: Colors.grey.shade100,suffixIcon:Icons.filter_list,
          ),
        ],
      ),
    );
  }
}