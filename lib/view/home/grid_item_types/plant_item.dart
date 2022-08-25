import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/cubit/cart/cart_cubit.dart';
import 'package:la_vie/model/cart/cart_model.dart';
import 'package:la_vie/view/home/grid_item_types/plant_info.dart';

import '../../../core/components/default_button.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/texts/app_text_styles.dart';
import '../../../model/home/plants.dart';

class PlantItem extends StatefulWidget {
  PlantItem({Key? key, required this.plant}) : super(key: key);
  Plant plant;

  @override
  State<PlantItem> createState() => _PlantItemState();
}

class _PlantItemState extends State<PlantItem> {
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
                "assets/images/grid${(widget.plant.hashCode % 2 == 0) ? 1 : 2}.png",
                //"https://lavie.orangedigitalcenteregypt.com${seed.imageUrl}",
                fit: BoxFit.cover,
                height: 120.h,
                width: 70.w,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //CountQuantityWidget(),
                    PlantInfo(
                        text: "${widget.plant.temperature}\xB0c",
                        icon: Icons.thermostat_outlined),
                    PlantInfo(
                        text: widget.plant.sunLight.toString(),
                        icon: Icons.sunny),
                    PlantInfo(
                        text: widget.plant.waterCapacity.toString(),
                        icon: Icons.water_drop),
                  ],
                ),
              ),
            ],
          ),
          Text(
            widget.plant.name,
            style: AppTextStyle.title(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.plant.description,
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
                  id: widget.plant.plantId,
                  name: widget.plant.name,
                  quantity: (quantity > 0) ? quantity : 1,
                  //imageUrl: plant.imageUrl,
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