import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidjab_user/utils/styles/size.dart';

import '../../../utils/icons/appIcons.dart';


class RejimItems extends StatelessWidget {
  const RejimItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.w),
              bottomLeft: Radius.circular(5.w),
            ),
          ),
          child: Center(
            child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  AppIcons.twoScreenWin,
                  height: 16.h,
                )),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5.w),
              bottomRight: Radius.circular(5.w),
            ),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Center(
            child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  AppIcons.twoScreenMenuButton,
                  height: 16.h,
                )),
          ),
        ),
      ],
    );
  }
}
