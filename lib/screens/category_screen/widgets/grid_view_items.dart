import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidjab_user/utils/icons/app_icons.dart';
import 'package:hidjab_user/utils/styles/app_text_style.dart';
import 'package:hidjab_user/utils/styles/size.dart';

import '../../../utils/colors/app_colors.dart';

class GridViewContainer extends StatelessWidget {
  const GridViewContainer(
      {super.key,
      required this.image,
      required this.price,
      required this.onTap,
      required this.rate,
      required this.productName,
      required this.order});

  final String image;
  final String price;
  final String rate;
  final String productName;
  final String order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          border: Border.all(width: 1, color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>  const Icon(Icons.error, color: Colors.red,),
              width: 100.w,
              height: 100.h,
            ),
            const SizedBox(height: 10),
            Text(
              productName,
              style: AppTextStyle.width400,
            ),
            Text(
              "\$ $price",
              style: AppTextStyle.width500.copyWith(color: AppColors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.star),
                SizedBox(
                  width: 10.w,
                ),
                Text(rate,
                    style:
                        AppTextStyle.width500.copyWith(color: Colors.orange)),
                SizedBox(
                  width: 10.w,
                ),

              ],
            ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SvgPicture.asset(AppIcons.dot),
               SizedBox(width: 5.w,),
               Text(
                 "$order Orders",
                 style: AppTextStyle.width400.copyWith(
                   color: Colors.grey,
                 ),
               overflow: TextOverflow.ellipsis,
               ),

             ],
           )
          ],
        ),
      ),
    );
  }
}
