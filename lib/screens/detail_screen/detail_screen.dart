import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidjab_user/bloc/basket/basket_bloc.dart';
import 'package:hidjab_user/bloc/basket/basket_event.dart';
import 'package:hidjab_user/bloc/product/product_bloc.dart';
import 'package:hidjab_user/data/models/product_model.dart';
import 'package:hidjab_user/screens/routes.dart';
import 'package:hidjab_user/utils/colors/app_colors.dart';
import 'package:hidjab_user/utils/icons/app_icons.dart';
import 'package:hidjab_user/utils/styles/size.dart';
import '../../bloc/product/product_state.dart';
import '../../data/models/basket_model.dart';
import '../../utils/styles/app_text_style.dart';
import '../category_screen/widgets/grid_view_items.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // List<String> images = splitImages(widget.productModel.images);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text("Descriptions"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.basketScreen,
              );
            },
            icon: SvgPicture.asset(
              AppIcons.carts,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12.w),
                      width: double.infinity,
                      height: 405.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.zero,
                        color: AppColors.white,
                        border: Border.all(
                          width: 1,
                          color: AppColors.black,
                        ),
                      ),
                      child: Image.network(
                        widget.productModel.imageUrl,
                        height: 305.h,
                        width: width,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 10.h,
                      left: 250.w,
                      child: Container(
                        height: 30.w,
                        width: 110.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(
                            .25,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                AppIcons.arrowBack,
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                AppIcons.arrowNext,
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Product Name",
                                  style: AppTextStyle.width500.copyWith(
                                      color: Colors.grey.shade500,
                                      fontSize: 16)),
                              Text("Price ",
                                  style: AppTextStyle.width500.copyWith(
                                      color: Colors.grey.shade500,
                                      fontSize: 16)),
                              Text("Rate",
                                  style: AppTextStyle.width500.copyWith(
                                      color: Colors.grey.shade500,
                                      fontSize: 16)),
                            ],
                          ),
                          SizedBox(
                            width: 60.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.productModel.productName,
                                  style: AppTextStyle.width500.copyWith(
                                      color: AppColors.black, fontSize: 16)),
                              Text(
                                  "${widget.productModel.price.toString()} Сум",
                                  style: AppTextStyle.width500.copyWith(
                                      color: AppColors.black, fontSize: 16)),
                              Text("${widget.productModel.rate.toString()} ⭐️",
                                  //⭐️⭐️⭐️⭐️
                                  style: AppTextStyle.width500.copyWith(
                                      color: AppColors.black, fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              BasketModel basketModel = BasketModel(
                                imageUrl: widget.productModel.imageUrl,
                                // categoryName: widget.productModel.categoryName,
                                // images: widget.productModel.images,
                                // description: widget.productModel.description,
                                price: widget.productModel.price,
                                productName: widget.productModel.productName,
                                // rate: widget.productModel.rate,
                                // modelName: widget.productModel.modelName,
                                allPrice: widget.productModel.price,
                                countOfProducts: 1,
                                uuid: '',
                                categoryName: '',
                                images: '',
                                description: '',
                                rate: 2,
                                modelName: '',
                                userId: FirebaseAuth.instance.currentUser!.uid,
                              );
                              context.read<BasketBloc>().add(
                                    AddToBasketEvent(
                                      basketModel: basketModel,
                                    ),
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blue,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                    ),
                                  ),
                                  content: Text(
                                    "Basketga bitta mahsulot qoshildi",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.width600.copyWith(
                                        fontSize: 20.w, color: Colors.white),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 280.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: AppColors.c1A72DD,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Buy now",
                                  style: AppTextStyle.width500
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors
                                          .grey.shade500) // Change color here
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  AppIcons.favourite,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.c1A72DD,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: AppTextStyle.width600,
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            widget.productModel.bookDescription,
                            style: AppTextStyle.width600
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        "  Consumer Electronics",
                        style: AppTextStyle.width500
                            .copyWith(fontSize: 18, color: AppColors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              state.products.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridViewContainer(
                                  image: state.products[index].imageUrl,
                                  price: state.products[index].price.toString(),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.productDetailScreen,
                                      arguments: state.products[index],
                                    );
                                  },
                                  rate: state.products[index].rate.toString(),
                                  productName:
                                      state.products[index].productName,
                                  order: '',
                                  // order: state.products[index].countOfOrders
                                  //     .toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
