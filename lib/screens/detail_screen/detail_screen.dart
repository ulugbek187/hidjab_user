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
import 'package:hidjab_user/utils/image/appimage.dart';
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
          SvgPicture.asset(AppIcons.profile),
          SizedBox(
            width: 20.w,
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
                      width: double.infinity,
                      height: 405.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.zero,
                          color: AppColors.white,
                          border: Border.all(width: 1, color: AppColors.black)),
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
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                AppIcons.arrowNext,
                                color: Colors.white,
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
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.star),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(widget.productModel.rate.toString(),
                              style: AppTextStyle.width500
                                  .copyWith(color: AppColors.c909499)),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(AppIcons.dot),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(AppIcons.message),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("reviews", style: AppTextStyle.width500),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(AppIcons.dot),
                          SizedBox(
                            width: 10.w,
                          ),
                          // Text(widget.productModel.countOfOrders.toString(),
                          //     style: AppTextStyle.width500),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(widget.productModel.productName,
                          style: AppTextStyle.width500
                              .copyWith(color: AppColors.black, fontSize: 20)),
                      Row(
                        children: [
                          Text("${widget.productModel.price.toString()} \$",
                              style: AppTextStyle.width500.copyWith(
                                  color: AppColors.cFF9017, fontSize: 20)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("(50-100 pcs)",
                              style: AppTextStyle.width500.copyWith(
                                  color: Colors.grey.shade500, fontSize: 15)),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
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
                                uuid: '', categoryName: '', images: '', description: '', rate: 2, modelName: '',
                              );
                              context.read<BasketBloc>().add(
                                    AddToBasketEvent(
                                      basketModel: basketModel,
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
                            height: 10.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Model",
                                  style: AppTextStyle.width500.copyWith(
                                      color: Colors.grey.shade500,
                                      fontSize: 16)),
                              Text("rate",
                                  style: AppTextStyle.width500.copyWith(
                                      color: Colors.grey.shade500,
                                      fontSize: 16)),
                              Text("category ",
                                  style: AppTextStyle.width500.copyWith(
                                      color: Colors.grey.shade500,
                                      fontSize: 16)),
                              Text("Reviews",
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
                              // Text(widget.productModel.modelName,
                              //     style: AppTextStyle.width500.copyWith(
                              //         color: AppColors.black, fontSize: 16)),
                              Text(
                                  "${widget.productModel.rate.toString()} ⭐️⭐️⭐️⭐️",
                                  style: AppTextStyle.width500.copyWith(
                                      color: AppColors.black, fontSize: 16)),
                              // Text(widget.productModel.globalCategory,
                              //     style: AppTextStyle.width500.copyWith(
                              //         color: AppColors.black, fontSize: 16)),
                              // Text(widget.productModel.countOfOrders.toString(),
                              //     style: AppTextStyle.width500.copyWith(
                              //         color: AppColors.black, fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                          "Info about edu item is an ideal companion for anyone engaged in learning. The drone provides precise and ..."),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Read More",
                            style: AppTextStyle.width500
                                .copyWith(color: AppColors.c1A72DD),
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 150.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors
                                .white), // Set the background color here
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Supplier'),
                              subtitle: const Text('Guanjon tRading LLC'),
                              leading: Container(
                                width: 48.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.c909499),
                                child: Center(
                                    child: Text(
                                  "R",
                                  style: AppTextStyle.width500.copyWith(
                                      color: AppColors.black, fontSize: 30.w),
                                )),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                    AppIcons.twoScreenPoluMenuButton),
                              ),
                              onTap: () {
                                // Handle tap
                              },
                            ),
                            const Divider(),
                            SizedBox(
                              height: 5.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 30.w,
                                        height: 30.h,
                                        child: Image.asset(AppImages.avatar)),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Germany",
                                      style: AppTextStyle.width500,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 30.w,
                                        height: 30.h,
                                        child:
                                            SvgPicture.asset(AppIcons.globus)),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Shopping",
                                      style: AppTextStyle.width500,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Consumer Electronics",
                        style: AppTextStyle.width500
                            .copyWith(fontSize: 18, color: AppColors.black),
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
                                      state.products[index].productName, order: '',
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
