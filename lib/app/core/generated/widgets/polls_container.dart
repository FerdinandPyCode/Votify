import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/strings.dart';

import '../../constants/color.dart';
import 'app_input_end_text_widget/app_text.dart';

class PollsWidgets {
  static Widget pollFirstTemplate(
      {String title = '',
      String subTitle = '',
      String trailing = '75',
      required VoidCallback action,
      bool isFinish = true}) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        width: double.infinity,
        height: 70.0,
        decoration: BoxDecoration(
            color: AppColors.blueBSkygColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: AppColors.greyColor,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: const Offset(1, 2)),
            ]),
        child: ListTile(
          title: AppText(
            title,
            color: AppColors.blackColor,
            weight: FontWeight.bold,
            size: 12.0,
          ),
          subtitle: AppText(
            subTitle,
            color: AppColors.blackColor,
            size: 12.0,
          ),
          trailing: AppText(
            '$trailing%',
            color: AppColors.blueBgColor,
            size: 25.0,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Widget pollSecondeTemplate(
      {String title = '',
      String nbrVotes = '',
      String nbrOptions = '4',
      required VoidCallback action}) {
    return InkWell(
      onTap: action,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
              color: AppColors.blueBSkygColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: AppColors.greyColor,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                    offset: const Offset(1, 2)),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                StringData.pollTitle,
                color: AppColors.blackColor,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AssetData.twoPeople),
                      const SizedBox(
                        width: 10.0,
                      ),
                      AppText(
                        '$nbrVotes ${StringData.voters}',
                        color: AppColors.greyBlackColor,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AssetData.valide),
                      const SizedBox(
                        width: 10.0,
                      ),
                      AppText(
                        '$nbrOptions ${StringData.options}',
                        color: AppColors.greyBlackColor,
                      )
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }

  static Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    return pickedDate;
  }
}
