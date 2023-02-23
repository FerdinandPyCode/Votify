import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constants/color.dart';
import '../../constants/strings.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final VoidCallback action;
  final TextEditingController controller;
  const SearchWidget({super.key, required this.hintText, required this.action, required this.controller});

  get searchController => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: AppColors.greyColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Search boutton onPress
          IconButton(
              onPressed: action,
              icon: Icon(
                Icons.search,
                color: AppColors.greyBlackColor,
                size: 35.0,
              )),
          //TextFields
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (value) {},
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: AppColors.greyColor),
                border: InputBorder.none,
              ),
              obscureText: false,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15, color: AppColors.blackColor),
              minLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
