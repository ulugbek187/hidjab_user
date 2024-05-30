import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hidjab_user/utils/colors/app_colors.dart';
import '../../../utils/styles/size.dart';

class FavouriteContainer extends StatelessWidget {
  const FavouriteContainer({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.onTap,
  });

  final String imageUrl;
  final String productName;
  final double price;
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
        ],
      ),
    );
  }
}
