import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/models/vote_model.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/screem/home_screem/home_screem.dart';
import 'package:votify_2/app/screem/voting_screems/user_vote.dart';

import '../../core/constants/color.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';
import '../../core/generated/widgets/polls_container.dart';
import '../../core/generated/widgets/search_widget.dart';

class VoteProgresScreem extends StatefulWidget {
  final List<Vote> liste;
  const VoteProgresScreem(this.liste, {super.key});

  @override
  State<VoteProgresScreem> createState() => _VoteProgresScreemState();
}

class _VoteProgresScreemState extends State<VoteProgresScreem> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MyAppBar(
        leadingWidget: IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const MyHomeScreem()));
              navigateToNextPage(context, const MyHomeScreem(), back: false);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.blueBgColor)),
      ),
      bottomNavigationBar: const MyBottomNavigation(
        currentIndex: 0,
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
                    StringData.voteInProgress,
                    color: AppColors.blueBgColor,
                    weight: FontWeight.bold,
                    size: 20.0,
                  ),
                ),
                Center(
                  child: Image.asset(
                    AssetData.pollPhone,
                    alignment: Alignment.topCenter,
                  ),
                ),
                //List of voting progress
                ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.liste.length,
                    itemBuilder: (context, int index) {
                      return PollsWidgets.pollSecondeTemplate(
                          nbrOptions: widget.liste[index].listeOptions.length
                              .toString(),
                          nbrVotes:
                              widget.liste[index].listeVote.length.toString(),
                          title: widget.liste[index].title,
                          action: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserVoteTemplate(widget.liste[index])));
                          });
                    }),
              ],
            )),
      ),
    );
  }
}
