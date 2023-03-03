import 'package:flutter/material.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/screem/voting_screems/vote_search_result_screem.dart';

import '../../constants/color.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final VoidCallback action;
  final TextEditingController controller;
  final Function(String)? onChanged;
  int here = 0;
  SearchWidget(
      {super.key,
      required this.hintText,
      required this.action,
      required this.controller,
      required this.onChanged,
      this.here = 0});

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
          Icon(
            Icons.search,
            color: AppColors.greyBlackColor,
            size: 35.0,
          ),
          //TextFields
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (value) {
                return null;
              },
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
              onTap: () {
                if (here == 0) {
                  navigateToNextPageWithTransition(
                      context, const SearchVoteResult());
                }
              },
              onChanged: onChanged,
            ),
          )
        ],
      ),
    );
  }
}
