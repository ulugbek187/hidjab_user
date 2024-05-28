import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';

class GlobalTextButton extends StatelessWidget {
  const GlobalTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isLoading
              ? AppColors.c1A72DD.withOpacity(0.5)
              : AppColors.c00B517,
        ),
        onPressed: isLoading ? () {} : onTap,
        child: isLoading
            ? const CupertinoActivityIndicator(
                color: Colors.white,
              )
            : Text(
                text,
                style: AppTextStyle.width600
                    .copyWith(fontSize: 14, color: Colors.white),
              ),
      ),
    );
  }
}
