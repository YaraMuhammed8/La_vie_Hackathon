import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie/core/components/default_button.dart';
import 'package:la_vie/core/styles/colors/app_colors.dart';
import 'package:la_vie/core/styles/texts/app_text_styles.dart';
import 'package:la_vie/core/utils/navigation.dart';
import 'package:la_vie/cubit/cart/cart_cubit.dart';
import 'package:la_vie/services/local/sql/sql_helper.dart';
import 'package:la_vie/view/cart/components/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SqlHelper.initDB();
    CartCubit.get(context).getAllCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "My Cart",
              style: AppTextStyle.appBarText(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: (cubit.products == null)
                ? const CircularProgressIndicator()
                : (cubit.products!.isEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 45.h,
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
                            "Your cart is empty",
                            style: AppTextStyle.headLine(),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Sorry, your cart is empty,go back to see products and fill your cart and make order",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.subTitle(),
                          ),
                          IconButton(
                              onPressed: () {
                                NavigationUtils.navigateBack(
                                    context: context);
                              },
                              icon: Icon(
                                Icons.arrow_back_outlined,
                                color: AppColors.primaryColor,
                              ))
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.all(10),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => CartItem(
                                cartModel: cubit.products![index],
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 25.h,
                              ),
                              itemCount: cubit.products!.length,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: AppTextStyle.bodyText(),
                                ),
                                Text(
                                  "${cubit.price} EGP",
                                  style: AppTextStyle.subTitle().copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          DefaultButton(
                            onPress: () {},
                            text: "Checkout",
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}
