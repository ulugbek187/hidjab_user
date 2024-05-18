import 'package:flutter/material.dart';
import 'package:hidjab_user/utils/styles/app_text_style.dart';
import 'package:hidjab_user/utils/styles/size.dart';

import '../../../utils/colors/app_colors.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.c_EFF2F4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.w),
          ),
        ),
        child: Text(
          title,
          style: AppTextStyle.width500
              .copyWith(color: AppColors.c_0D6EFD, fontSize: 16.w),
        ),
      ),
    );
  }
}
