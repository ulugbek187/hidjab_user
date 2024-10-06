import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidjab_user/bloc/user/user_bloc.dart';
import 'package:hidjab_user/screens/global_screen/widgets/lenguege/languages_screen.dart';
import 'package:hidjab_user/screens/routes.dart';
import 'package:hidjab_user/utils/icons/app_icons.dart';
import 'package:hidjab_user/utils/image/appimage.dart';
import 'package:hidjab_user/utils/styles/size.dart';

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
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppImages.avatar,
                      width: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.userModel.username,
                      style:
                          AppTextStyle.width600.copyWith(color: Colors.white),
                    ),Text(
                      '+${state.userModel.phoneNumber}',
                      style:
                          AppTextStyle.width600.copyWith(color: Colors.white),
                    ),
                  ],
                );
              },
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
                arguments: ["All"],
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
            onTap: () {
              Navigator.pushNamed(context, RouteNames.favourite);
            },
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AppIcons.carts,
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
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
          // SizedBox(
          //   height: 5.h,
          // ),
          // Container(
          //   width: width,
          //   height: 1.h,
          //   margin: EdgeInsets.symmetric(horizontal: 10.w),
          //   color: Colors.grey,
          // ),
          // SizedBox(
          //   height: 5.h,
          // ),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingLanguagesScreen(),
                ),
              );
            },
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
            onTap: () {
              Navigator.pushNamed(context, RouteNames.contactUsScreen);
            },
          ),
          // ListTile(
          //   title: Row(
          //     children: [
          //       SvgPicture.asset(AppIcons.about),
          //       SizedBox(
          //         width: 16.w,
          //       ),
          //       Text(
          //         "About",
          //         style: AppTextStyle.width500.copyWith(
          //           color: Colors.black,
          //         ),
          //       ),
          //     ],
          //   ),
          //   onTap: () {},
          // ),
          // SizedBox(
          //   height: 5.h,
          // ),
          // Container(
          //   width: width,
          //   height: 1.h,
          //   margin: EdgeInsets.symmetric(horizontal: 10.w),
          //   color: Colors.grey,
          // ),
          // SizedBox(
          //   height: 5.h,
          // ),
          // ListTile(
          //   title: Row(
          //     children: [
          //       SizedBox(
          //         width: 35.w,
          //       ),
          //       Text(
          //         "User agreement",
          //         style: AppTextStyle.width500.copyWith(
          //           color: Colors.black,
          //         ),
          //       ),
          //     ],
          //   ),
          //   onTap: () {},
          // ),
          // ListTile(
          //   title: Row(
          //     children: [
          //       SizedBox(
          //         width: 35.w,
          //       ),
          //       Text(
          //         "Partnership",
          //         style: AppTextStyle.width500.copyWith(
          //           color: Colors.black,
          //         ),
          //       ),
          //     ],
          //   ),
          //   onTap: () {},
          // ),
          // ListTile(
          //   title: Row(
          //     children: [
          //       SizedBox(
          //         width: 35.w,
          //       ),
          //       Text(
          //         "Privacy policy",
          //         style: AppTextStyle.width500.copyWith(
          //           color: Colors.black,
          //         ),
          //       ),
          //     ],
          //   ),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
