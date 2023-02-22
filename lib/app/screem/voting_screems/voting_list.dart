import 'package:flutter/material.dart';
import 'package:votify/app/core/constants/asset_data.dart';
import 'package:votify/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify/app/screem/home_screem/home_screem.dart';
import 'package:votify/app/screem/voting_screems/final_vote.dart';

import '../../core/constants/color.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';
import '../../core/generated/widgets/polls_container.dart';
import '../../core/generated/widgets/search_widget.dart';

class VotingListScreem extends StatefulWidget {
  const VotingListScreem({super.key});

  @override
  State<VotingListScreem> createState() => _VotingListScreemState();
}

class _VotingListScreemState extends State<VotingListScreem> {
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
      bottomNavigationBar: const MyBottomNavigation(currentIndex: 0,),
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
                  action: () {},
                  controller: searchController,
                  hintText: StringData.searchPolls,
                ),

                //Body fo the page
                const SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: AppText(
                    StringData.votingList,
                    color: AppColors.blueBgColor,
                    weight: FontWeight.bold,
                    size: 20.0,
                  ),
                ),
                const SizedBox(height: 16.0,),

                //List of voting progress
                ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                  
                  return  PollsWidgets.pollSecondeTemplate(
                    nbrOptions: '4',
                    nbrVotes: '68',
                    title: StringData.pollTitle,
                    action: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const FinalVoteTemplate(//isAdmin:isAdmin
                    )));
                    });
                })
                
                
              ],
            )),
      ),
    );
  }
}
