import 'package:flutter/material.dart';
import 'package:hidjab_user/utils/colors/app_colors.dart';
import 'package:hidjab_user/utils/styles/size.dart';

class GlobalButtons extends StatelessWidget {
  const GlobalButtons(
      {super.key,
      required this.title,
      required this.voidCallback,
      required this.color});

  final String title;
  final VoidCallback voidCallback;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.w),
            border: Border.all(width: 1.h, color: AppColors.black)),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 13.w, color: color, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
