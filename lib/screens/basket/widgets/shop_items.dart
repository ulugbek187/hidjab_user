import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidjab_user/utils/colors/app_colors.dart';
import 'package:hidjab_user/utils/icons/app_icons.dart';
import '../../../utils/styles/size.dart';

class ShopContainer extends StatelessWidget {
  const ShopContainer({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.description,
    required this.price,
    required this.count,
    required this.minusOnTap,
    required this.plusOnTap,
    required this.onTap,
  });

  final String imageUrl;
  final String productName;
  final String description;
  final double price;
  final int count;
  final VoidCallback minusOnTap;
  final VoidCallback plusOnTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.w,
            color: AppColors.cEFF2F4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.w),
                    border: Border.all(width: 1.w, color: Colors.grey)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.w),
                  child: CachedNetworkImage(
                    placeholder: (context, state) {
                      return const CircularProgressIndicator();
                    },
                    errorWidget: (context, state, ob) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    },
                    imageUrl: imageUrl,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                width: 175.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.w,
                          color: AppColors.c1C1C1C),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.w,
                          color: AppColors.c8B96A5),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.w),
                  border: Border.all(width: 1.h, color: AppColors.cDEE2E7),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: minusOnTap,
                      icon: SvgPicture.asset(AppIcons.minus),
                    ),
                    Container(height: 40.h, width: 1.w, color: Colors.grey),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      count.toString(),
                      style:
                          TextStyle(fontSize: 16.w, color: AppColors.c1C1C1C),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(height: 40.h, width: 1.w, color: Colors.grey),
                    IconButton(
                      onPressed: plusOnTap,
                      icon: SvgPicture.asset(AppIcons.plus),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                "$price Сум",
                style: TextStyle(fontSize: 16.w, color: AppColors.c1C1C1C),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
