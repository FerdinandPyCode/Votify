import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:votify_2/app/screem/voting_screems/final_vote.dart';

import '../../core/constants/color.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/app_text.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';
import '../../core/generated/widgets/polls_container.dart';

class MyHistorieScreem extends StatefulWidget {
  const MyHistorieScreem({super.key});

  @override
  State<MyHistorieScreem> createState() => _MyHistorieScreemState();
}

class _MyHistorieScreemState extends State<MyHistorieScreem> {
  bool isPublic = true;
//Preparation des données pour le graphique
  List<FlSpot> data = [
    const FlSpot(0, 0),
    const FlSpot(1, 2),
    const FlSpot(2, 0),
    const FlSpot(3, 0),
    const FlSpot(4, 3),
    const FlSpot(5, 1),
    const FlSpot(6, 0),
    const FlSpot(7, 5),
  ];

//Pichart Data
  List<PieChartSectionData> pieChartRawData = [
    PieChartSectionData(
      color: AppColors.blueBgColor,
      value: 25,
      title: '75%',
      radius: 50,
    ),
    PieChartSectionData(
      color: AppColors.violetColor,
      value: 25,
      title: '25%',
      radius: 50,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MyAppBar(
        leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(Icons.arrow_back, color: AppColors.blueBgColor)),
      ),
      bottomNavigationBar: const MyBottomNavigation(
        currentIndex: 1,
      ),
      floatingActionButton: const FlotingActionButon(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppText(
                  StringData.history,
                  color: AppColors.blueBgColor,
                  weight: FontWeight.bold,
                  size: 20.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              // Overview for last 7 days
              AppText(
                StringData.overview,
                color: AppColors.blackColor,
                size: 12.0,
              ),
              const SizedBox(
                height: 12.0,
              ),

              SizedBox(
                width: double.infinity,
                height: 200.0,
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(enabled: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: data,
                        isCurved: true,
                        barWidth: 2,
                        color: AppColors.violetColor,
                      ),
                    ],
                  ),
                  swapAnimationDuration:
                      const Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ),
              ),

              const SizedBox(
                height: 16.0,
              ),

              //Pi chart
              AppText(
                StringData.numbersPolls,
                color: AppColors.blackColor,
                size: 15.0,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: const [],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Public button
                  InkWell(
                    onTap: (() {
                      setState(() {
                        isPublic = true;
                      });
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: isPublic
                          ? BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                              color: AppColors.greySkyColor)
                          : null,
                      width: width / 2.3,
                      height: 40.0,
                      child: AppText(
                        StringData.public,
                        color: isPublic
                            ? AppColors.blueBgColor
                            : AppColors.violetColor,
                        weight: isPublic ? FontWeight.bold : FontWeight.normal,
                        size: isPublic ? 20.0 : 15.0,
                      ),
                    ),
                  ),

                  // Private button
                  InkWell(
                    onTap: (() {
                      setState(() {
                        isPublic = false;
                      });
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: (isPublic != true)
                          ? BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                              color: AppColors.greySkyColor)
                          : null,
                      width: width / 2.3,
                      height: 40.0,
                      child: AppText(
                        StringData.private,
                        color: (isPublic != true)
                            ? AppColors.blueBgColor
                            : AppColors.violetColor,
                        weight: (isPublic != true)
                            ? FontWeight.bold
                            : FontWeight.normal,
                        size: (isPublic != true) ? 20.0 : 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * .01),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(10.0),
                        bottomRight: const Radius.circular(10.0),
                        topLeft: isPublic
                            ? const Radius.circular(0.0)
                            : const Radius.circular(10.0),
                        topRight: !isPublic
                            ? const Radius.circular(0.0)
                            : const Radius.circular(10.0)),
                    color: AppColors.greySkyColor),
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return PollsWidgets.pollFirstTemplate(
                          title: StringData.pollTitle,
                          subTitle: StringData.pollSousTitle,
                          trailing: '75',
                          action: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FinalVoteTemplate()));
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
