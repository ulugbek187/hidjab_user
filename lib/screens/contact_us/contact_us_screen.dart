import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidjab_user/utils/icons/app_icons.dart';
import 'package:hidjab_user/utils/image/appimage.dart';
import 'package:hidjab_user/utils/styles/app_text_style.dart';
import 'package:hidjab_user/utils/styles/size.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri phoneNumberU = Uri.parse("tel:+998910110353");
final Uri phoneNumberM = Uri.parse("tel:+998976843132");
final Uri gmailU = Uri.parse("https://mail.google.com/mail/u/0/#inbox");
final Uri gmailM = Uri.parse("ulugbekmirvokhidov@gmail.com");

final Uri telegramURLU = Uri.parse("https://t.me/ulugbek171");
final Uri telegramURLM = Uri.parse("https://t.me/ulugbek171");

final Uri instagramURLU = Uri.parse(
    "https://www.instagram.com/not_legal_187?igsh=MWRwZTFsbWZiN2d2NQ==");

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Contact Us",
            style: AppTextStyle.width700.copyWith(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 20.w),
              width: double.infinity,
              height: 1.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Image.asset(
                AppImages.brandMafia,
                width: double.infinity,
                height: 140.h,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Reach Us",
                  style: AppTextStyle.width700.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Admins",
                  style: AppTextStyle.width700.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppIcons.tel),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(phoneNumberU);
                      },
                      child: Text(
                        "+998 91 011 03 53",
                        style:
                            AppTextStyle.width600.copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(phoneNumberM);
                      },
                      child: Text(
                        "+998 97 684 31 32",
                        style:
                            AppTextStyle.width600.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Ulug'bek",
                      style:
                          AppTextStyle.width600.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Mir Ag'zam",
                      style:
                          AppTextStyle.width600.copyWith(color: Colors.white),
                    ),
                    // Text("Brand Mafia", style: AppTextStyle.width600.copyWith(color: Colors.white),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppIcons.pochta),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(gmailU);
                      },
                      child: Text(
                        "mirvokhidovulugbek@gmail.com",
                        style: AppTextStyle.width600
                            .copyWith(color: Colors.white, fontSize: 12.w),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(gmailM);
                      },
                      child: Text(
                        "mirvokhidovulugbek@gmail.com",
                        style: AppTextStyle.width600
                            .copyWith(color: Colors.white, fontSize: 12.w),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Ulug'bek",
                      style:
                          AppTextStyle.width600.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Mir Ag'zam",
                      style:
                          AppTextStyle.width600.copyWith(color: Colors.white),
                    ),
                    // Text("Brand Mafia", style: AppTextStyle.width600.copyWith(color: Colors.white),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppIcons.locatsiya),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(gmailU);
                      },
                      child: Text(
                        "132 Dartmouth Street Boston,\n Massachusetts 02156 United States",
                        style: AppTextStyle.width600
                            .copyWith(color: Colors.white, fontSize: 12.w),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppIcons.telegram,
                      color: Colors.white,
                      width: 26.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(telegramURLU);
                      },
                      child: Text(
                        "https://t.me/ulugbek171",
                        style: AppTextStyle.width600
                            .copyWith(color: Colors.white, fontSize: 12.w),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(telegramURLM);
                      },
                      child: Text(
                        "https://t.me/miragzam",
                        style: AppTextStyle.width600
                            .copyWith(color: Colors.white, fontSize: 12.w),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Ulug'bek",
                      style:
                          AppTextStyle.width600.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Mir Ag'zam",
                      style:
                          AppTextStyle.width600.copyWith(color: Colors.white),
                    ),
                    // Text("Brand Mafia", style: AppTextStyle.width600.copyWith(color: Colors.white),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppIcons.instagram,
                      color: Colors.white,
                      width: 26.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(instagramURLU);
                      },
                      child: Text(
                        "https://www.instagram.com/brand",
                        style: AppTextStyle.width600
                            .copyWith(color: Colors.white, fontSize: 12.w),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Brand Mafia",
                      style:
                          AppTextStyle.width600.copyWith(color: Colors.white),
                    ),

                    // Text("Brand Mafia", style: AppTextStyle.width600.copyWith(color: Colors.white),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
