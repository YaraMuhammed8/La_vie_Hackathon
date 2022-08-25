import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/cubit/cart/cart_cubit.dart';
import 'package:la_vie/model/cart/cart_model.dart';

import '../../../core/components/default_button.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/texts/app_text_styles.dart';
import '../../../model/home/tools.dart';

class ToolItem extends StatefulWidget {
  ToolItem({Key? key, required this.tool}) : super(key: key);
  Tool tool;

  @override
  State<ToolItem> createState() => _ToolItemState();
}

class _ToolItemState extends State<ToolItem> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.lightBackGroundColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 10,
                color: Colors.grey.shade300)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/grid${(widget.tool.hashCode % 2 == 0) ? 1 : 2}.png",
                //"https://lavie.orangedigitalcenteregypt.com${seed.imageUrl}",
                fit: BoxFit.cover,
                height: 120.h,
                width: 80.w,
                errorBuilder: (context, object, stacktrace) => SizedBox(
                  height: 120.h,
                  child: Icon(
                    Icons.image_outlined,
                    size: 80.h,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
            ],
          ),
          Text(
            widget.tool.name,
            style: AppTextStyle.title(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.tool.description,
            style: AppTextStyle.subTitle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5.h,
          ),
          const Spacer(),
          DefaultButton(
            onPress: () {
              CartCubit.get(context).addToCart(
                CartModel(
                  id: widget.tool.toolId,
                  name: widget.tool.name,
                  quantity: (quantity>0)?quantity:1,
                  //imageUrl: tool.imageUrl,
                ),
              );
            },
            text: "Add to cart",
            borderRadius: 10.r,
            height: 35.h,
          )
        ],
      ),
    );
  }
}
