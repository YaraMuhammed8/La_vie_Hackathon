import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';
import 'package:la_vie/cubit/cart/cart_cubit.dart';

class CountQuantity extends StatelessWidget {
  int quantity;
  String cartId;

  CountQuantity({Key? key, required this.quantity, required this.cartId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(3.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    if (quantity > 1) {
                      quantity--;
                      CartCubit.get(context)
                          .updateProductQuantity(quantity, cartId);
                    }
                  },
                  child: Transform.translate(
                    offset: Offset(0,-8),
                    child: Icon(
                      Icons.minimize,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Text(quantity.toString()),
                GestureDetector(
                  onTap: () {
                    quantity++;
                    CartCubit.get(context)
                        .updateProductQuantity(quantity, cartId);
                  },
                  child: Icon(
                    Icons.add,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ));
      },
    );
  }
}
