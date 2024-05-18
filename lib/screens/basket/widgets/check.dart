import 'package:flutter/material.dart';
import 'package:hidjab_user/utils/styles/size.dart';
import '../../../utils/colors/app_colors.dart';

class CheckoutItem extends StatelessWidget {
  const CheckoutItem({
    super.key,
    required this.countOfProducts,
    required this.allSumma,
    required this.productName,
  });

  final int countOfProducts;
  final double allSumma;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$productName ($countOfProducts)',
          style: TextStyle(fontSize: 16.w, color: AppColors.c8B96A5),
        ),
        const Spacer(),
        Text(
          allSumma.toString(),
          style: TextStyle(
              fontSize: 16.w,
              color: AppColors.c1C1C1C,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
