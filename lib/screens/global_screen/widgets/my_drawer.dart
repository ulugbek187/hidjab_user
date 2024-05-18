import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidjab_user/screens/routes.dart';
import 'package:hidjab_user/utils/image/appimage.dart';
import 'package:hidjab_user/utils/styles/size.dart';

import '../../../utils/icons/appIcons.dart';
import '../../../utils/styles/app_text_style.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.avatar,
                  width: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Sign in | Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(AppIcons.home),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  "Home",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(AppIcons.categoryButtonMenu),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  "Categories",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.categoryScreen,
                arguments: "All",
              );
            },
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(AppIcons.favourite),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  "Favorites",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AppIcons.carts,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  "Basket",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, RouteNames.basketScreen);
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: width,
            height: 1.h,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            color: Colors.grey,
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(AppIcons.globus),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  "English | USD",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(AppIcons.naushnik),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  "Contact us",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(AppIcons.about),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  "About",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: width,
            height: 1.h,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            color: Colors.grey,
          ),
          SizedBox(
            height: 5.h,
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 35.w,
                ),
                Text(
                  "User agreement",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 35.w,
                ),
                Text(
                  "Partnership",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 35.w,
                ),
                Text(
                  "Privacy policy",
                  style: AppTextStyle.width500.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
