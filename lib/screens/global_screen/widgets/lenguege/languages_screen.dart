import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hidjab_user/utils/image/appimage.dart';
import 'package:hidjab_user/utils/styles/size.dart';

class SettingLanguagesScreen extends StatelessWidget {
  const SettingLanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'language'.tr(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 40.h),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                context.setLocale(const Locale("uz", "UZ"));
              },
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(AppImages.uzbFlag,
                      height: 25.h, width: 25.w, fit: BoxFit.cover)),
              trailing: Icon(
                locale == "uz_UZ" ? Icons.check_circle : Icons.circle_outlined,
              ),
              title: const Text(
                "O'zbekcha",
              ),
            ),
            Divider(color: Theme.of(context).dividerColor),
            ListTile(
              onTap: () {
                context.setLocale(const Locale("ru", "RU"));
              },
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(AppImages.rusFlag,
                      height: 25.h, width: 25.w, fit: BoxFit.cover)),
              trailing: Icon(
                locale == "ru_RU" ? Icons.check_circle : Icons.circle_outlined,
              ),
              title: const Text(
                'Русский',
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                context.setLocale(const Locale("en", "US"));
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  AppImages.uzbFlag,
                  height: 25.h,
                  width: 25.w,
                  fit: BoxFit.cover,
                ),
              ),
              trailing: Icon(
                locale == "en_US" ? Icons.check_circle : Icons.circle_outlined,
              ),
              title: const Text(
                "English",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
