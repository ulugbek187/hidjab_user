import 'package:flutter/material.dart';
import 'package:hidjab_user/utils/styles/app_text_style.dart';

import '../widgets/global_textbutton.dart';

errorDialog({
  required BuildContext context,
  required String errorText,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "!!!",
                  style: AppTextStyle.width600
                      .copyWith(color: Colors.redAccent, fontSize: 20),
                ),
                Text(
                  errorText,
                  style: AppTextStyle.width600
                      .copyWith(color: Colors.redAccent, fontSize: 24),
                ),
                const SizedBox(height: 20),
                GlobalTextButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: "Ok")
              ],
            ),
          ),
        );
      });
}
