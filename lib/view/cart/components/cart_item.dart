import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';
import 'package:la_vie/cubit/cart/cart_cubit.dart';
import 'package:la_vie/model/cart/cart_model.dart';

import '../../../core/styles/texts/app_text_styles.dart';
import 'count_quantity.dart';

class CartItem extends StatefulWidget {
  final CartModel cartModel;
  const CartItem({
    Key? key,
    required this.cartModel,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      decoration: BoxDecoration(
        color: AppColors.lightBackGroundColor,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: -3,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                widget.cartModel.imageUrl!,
                fit: BoxFit.cover,
                height: 110.h,
                width: 130.w,
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartModel.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodyText(),
                  ),
                  Text(
                    '${widget.cartModel.price!} EGP',
                    textAlign: TextAlign.start,
                    style: AppTextStyle.bodyText().copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CountQuantity(
                    quantity: widget.cartModel.quantity!,
                    cartId: widget.cartModel.id!,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                CartCubit.get(context).removeProduct(widget.cartModel);
              },
              icon: const Icon(
                Icons.delete_rounded,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
