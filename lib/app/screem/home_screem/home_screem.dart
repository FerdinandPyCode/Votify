import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/generated/dynamique_button.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/utils/providers.dart';
import 'package:votify_2/app/screem/voting_screems/user_vote.dart';
import 'package:votify_2/app/screem/voting_screems/voting_progress.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';
import '../../core/generated/widgets/polls_container.dart';
import '../../core/generated/widgets/search_widget.dart';
import '../voting_screems/vote_search_result_screem.dart';
import '../voting_screems/voting_list.dart';

class MyHomeScreem extends ConsumerStatefulWidget {
  const MyHomeScreem({super.key});

  @override
  ConsumerState<MyHomeScreem> createState() => _MyHomeScreemState();
}

class _MyHomeScreemState extends ConsumerState<MyHomeScreem> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MyAppBar(
        leadingWidget: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu_sharp, color: AppColors.blueBgColor)),
      ),
      floatingActionButton: const FlotingActionButon(),
      bottomNavigationBar: const MyBottomNavigation(
        currentIndex: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                StringData.hi + ref.read(userAuth).me.username,
                color: AppColors.blackColor,
                weight: FontWeight.bold,
                size: 20.0,
              ),
              const SizedBox(
                height: 10.0,
              ),

              // Search boutton
              SearchWidget(
                action: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchVoteResult()));
                },
                controller: searchController,
                hintText: StringData.searchPolls,
              ),
              const SizedBox(
                height: 24.0,
              ),
              //Public Polls
              typePolls(action: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VoteProgresScreem()));
              }),
              const SizedBox(
                height: 16.0,
              ),
              //Private Polls
              typePolls(
                  publicPolls: false,
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VoteProgresScreem()));
                  }),
              const SizedBox(
                height: 16.0,
              ),
              Center(
                child: Image.asset(AssetData.greatMicro),
              ),

              const SizedBox(
                height: 16.0,
              ),
              AppText(
                StringData.recentPoll,
                color: AppColors.blackColor,
                weight: FontWeight.bold,
                size: 13.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              //Recent Polls
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return PollsWidgets.pollFirstTemplate(
                        title: StringData.pollTitle,
                        subTitle: StringData.pollSousTitle,
                        trailing: '75',
                        action: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserVoteTemplate(
                                      isAdmin: (index % 2 == 0))));
                        });
                  }),

              const SizedBox(
                height: 12.0,
              ),

              //Button go to list of list polls
              Align(
                alignment: Alignment.centerRight,
                child: DynamiqueButton(
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VotingListScreem()));
                  },
                  bgColor: AppColors.blueBgColor,
                  childs: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(
                        StringData.viewList,
                        color: AppColors.backgroundColor,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.backgroundColor,
                      )
                    ],
                  ),
                  height: 50.0,
                  radius: 10.0,
                  width: 150.0,
                ),
              ),

              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget typePolls(
      {double nbrPolls = 12,
      bool publicPolls = true,
      required VoidCallback action}) {
    return InkWell(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color:
                publicPolls ? AppColors.blueBgColor : AppColors.backgroundColor,
            boxShadow: [
              BoxShadow(
                  color:
                      publicPolls ? AppColors.greyColor : AppColors.blueBgColor,
                  spreadRadius: 1.0,
                  offset: const Offset(0, 1),
                  blurRadius: 10.0)
            ]),
        child: ListTile(
          //contentPadding: EdgeInsets.all(0.0),
          leading: publicPolls
              ? Image.asset(AssetData.privateIcon)
              : Image.asset(AssetData.publicIcon),
          title: AppText(
            '${nbrPolls.toInt()} ${StringData.privatePollActive}',
            color:
                publicPolls ? AppColors.backgroundColor : AppColors.blackColor,
            weight: FontWeight.bold,
            size: 13.0,
          ),
          subtitle: AppText(
            StringData.showDetail,
            color: AppColors.greyBlackColor,
            size: 12.0,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color:
                publicPolls ? AppColors.backgroundColor : AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
