import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidjab_user/utils/styles/size.dart';

import '../../../utils/icons/appIcons.dart';

class SortItems extends StatefulWidget {
  final VoidCallback onGridViewPressed;
  final VoidCallback onListViewPressed;

  const SortItems({
    super.key,
    required this.onGridViewPressed,
    required this.onListViewPressed,
  });

  @override
  State<SortItems> createState() => _SortItemsState();
}

class _SortItemsState extends State<SortItems> {
  String dropdownValue = 'Newest';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 135.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Sort:"),
              DropdownButton<String>(
                value: dropdownValue,
                icon: SvgPicture.asset(AppIcons.twoScreenPoluMenuButton),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Newest', 'Oldest', 'Middle']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(width: 5.w),
        Container(
          width: 135.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Filter:"),
              SvgPicture.asset(AppIcons.twoScreenFilterButton),
            ],
          ),
        ),
        SizedBox(width: 5.w),
        Container(
          width: 65.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.grey.shade300,
            ),
          ),
          child: Material(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: widget.onGridViewPressed,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    width: 30.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset(AppIcons.twoScreenWin),
                    ),
                  ),
                ),
                InkWell(
                  onTap: widget.onListViewPressed,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Colors.grey.shade300,
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset(AppIcons.menu),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
