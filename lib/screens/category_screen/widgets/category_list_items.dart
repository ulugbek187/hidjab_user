import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidjab_user/utils/icons/app_icons.dart';
import 'package:hidjab_user/utils/styles/app_text_style.dart';
import 'package:hidjab_user/utils/styles/size.dart';
import '../../../utils/colors/app_colors.dart';

class ListContainerView extends StatelessWidget {
  const ListContainerView(
      {super.key,
      required this.image,
      required this.price,
      required this.onTap});

  final String image;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      //     () {
      //   // Navigate to the product details screen
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const ProductDetailsScreen(productModel:,),
      //     ),
      //   );
      // },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        width: double.infinity,
        height: 114.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          border: Border.all(width: 1, color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 98.w,
              height: 98.h,
              child: Image.asset(image),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Regular fit resort shirt"),
                  Text(
                    "\$ $price",
                    style:
                        AppTextStyle.width400.copyWith(color: AppColors.black),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.star),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text("7.5",
                          style: AppTextStyle.width400
                              .copyWith(color: Colors.orange)),
                      SizedBox(
                        width: 10.w,
                      ),
                      SvgPicture.asset(AppIcons.dot),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text("154 orders", style: AppTextStyle.width400),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListViewContainer extends StatelessWidget {
  const ListViewContainer(
      {super.key,
      required this.image,
      required this.price,
      required this.onTap,
      required this.productName,
      required this.rate,
      required this.order});

  final String image;
  final String price;
  final VoidCallback onTap;
  final String productName;
  final String rate;
  final String order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          // height: 114.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 98.w,
                height: 98.h,
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>  const Icon(Icons.error, color: Colors.red,),
                  width: 120.w,
                  height: 140.h,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: AppTextStyle.width500,
                    ),
                    Text(
                      "\$ $price",
                      style: AppTextStyle.width400
                          .copyWith(color: AppColors.black),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.star),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(rate,
                            style: AppTextStyle.width400
                                .copyWith(color: Colors.orange)),
                        SizedBox(
                          width: 10.w,
                        ),
                        SvgPicture.asset(AppIcons.dot),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "$order Orders",
                          style: AppTextStyle.width400
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
