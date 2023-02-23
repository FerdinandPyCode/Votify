import 'package:flutter/material.dart';

import '../../core/constants/asset_data.dart';
import '../../core/constants/color.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/widgets/app_input_end_text_widget/app_text.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/dial_button.dart';
import '../../core/generated/widgets/polls_container.dart';
import '../../core/generated/widgets/search_widget.dart';
import '../home_screem/home_screem.dart';

class SearchVoteResult extends StatefulWidget {
  const SearchVoteResult({super.key});

  @override
  State<SearchVoteResult> createState() => _SearchVoteResultState();
}

class _SearchVoteResultState extends State<SearchVoteResult> {
TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MyAppBar(
        leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.blueBgColor)),
      ),
      floatingActionButton: const FlotingActionButon(),
      body: SingleChildScrollView(
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Search widgets
                SearchWidget(
                  action: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchVoteResult()));
                  },
                  controller: searchController,
                  hintText: StringData.which,
                ),

                //Body fo the page
                const SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: AppText(
                    StringData.results,
                    color: AppColors.blackColor,
                    weight: FontWeight.bold,
                    size: 20.0,
                  ),
                ),
                
                const SizedBox(
                  height: 16.0,
                ),
                //List of voting progress
                PollsWidgets.pollSecondeTemplate(
                    nbrOptions: '4',
                    nbrVotes: '68',
                    title: StringData.pollTitle,
                    action: () {}),
                PollsWidgets.pollSecondeTemplate(
                    nbrOptions: '4',
                    nbrVotes: '68',
                    title: StringData.pollTitle,
                    action: () {}),
                PollsWidgets.pollSecondeTemplate(
                    nbrOptions: '4',
                    nbrVotes: '68',
                    title: StringData.pollTitle,
                    action: () {}),
                PollsWidgets.pollSecondeTemplate(
                    nbrOptions: '4',
                    nbrVotes: '68',
                    title: StringData.pollTitle,
                    action: () {}),
                PollsWidgets.pollSecondeTemplate(
                    nbrOptions: '4',
                    nbrVotes: '68',
                    title: StringData.pollTitle,
                    action: () {}),
                PollsWidgets.pollSecondeTemplate(
                    nbrOptions: '4',
                    nbrVotes: '68',
                    title: StringData.pollTitle,
                    action: () {}),
                PollsWidgets.pollSecondeTemplate(
                    nbrOptions: '4',
                    nbrVotes: '68',
                    title: StringData.pollTitle,
                    action: () {}),
                PollsWidgets.pollSecondeTemplate(
                    nbrOptions: '4',
                    nbrVotes: '68',
                    title: StringData.pollTitle,
                    action: () {})
              ],
            )),
      ),
    );
  }
}