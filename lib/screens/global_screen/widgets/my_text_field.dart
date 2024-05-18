import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidjab_user/utils/styles/size.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.type,
    required this.iconPath,
    required this.hinText,
    required this.onChanged, required this.controller,
  });

  final TextInputType type;
  final String iconPath;
  final String hinText;
  final ValueChanged onChanged;
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      onChanged: onChanged,
      controller: controller,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.05000000074505806),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 15,
        ),
        errorStyle:
            const TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.orange,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.blue,
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(11.w),
          child: SvgPicture.asset(iconPath),
        ),
        hintText: hinText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15.w,
          color: Colors.grey,
        ),
      ),
    );
  }
}




