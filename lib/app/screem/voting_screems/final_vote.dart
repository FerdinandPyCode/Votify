import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/strings.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/models/vote_model.dart';

import '../../core/constants/color.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';

class FinalVoteTemplate extends StatefulWidget {
  final Vote vote;
  const FinalVoteTemplate(this.vote, {super.key});

  @override
  State<FinalVoteTemplate> createState() => _FinalVoteTemplateState();
}

class _FinalVoteTemplateState extends State<FinalVoteTemplate> {
  int nbrVoters = 0;

  @override
  void initState() {
    nbrVoters = widget.vote.listeVote.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        currentIndex: 0,
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
              Row(
                children: [
                  Image.asset(
                    AssetData.twoPeople,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  AppText(
                    '${widget.vote.listeVote.length} ${StringData.voters}',
                    color: AppColors.blackColor,
                    size: 13.0,
                    weight: FontWeight.bold,
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              AppText(
                widget.vote.title,
                color: AppColors.blackColor,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10.0,
              ),

              //List of options
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.vote.listeOptions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: AppColors.blueBSkygColor2,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: AppColors.greyColor)),
                      width: double.infinity,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                            widget.vote.listeOptions[index].fullName,
                            color: AppColors.greyBlackColor,
                            size: 13.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //(optionList[index]['isBest'] == true)
                              //?
                              Image.asset(
                                AssetData.valide,
                                color: AppColors.blueBgColor,
                              ),
                              //: const AppText(''),
                              const SizedBox(
                                width: 5.0,
                              ),
                              AppText(
                                "50",
                                weight: FontWeight.bold,
                                color: AppColors.blueBgColor,
                                size: 20.0,
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
              Center(child: Image.asset(AssetData.micro)),
              Center(
                  child: AppText(
                StringData.votersList,
                color: AppColors.blackColor,
                weight: FontWeight.bold,
                size: 20.0,
              )),
              const SizedBox(
                height: 10.0,
              ),

              //Voters List

              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: nbrVoters,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 50.0,
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5.0,
                                spreadRadius: 0.0,
                                color: AppColors.blueBgColor,
                                offset: const Offset(0, 1))
                          ]),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.greySkyColor,
                            backgroundImage: AssetImage(AssetData.google),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          AppText(
                            StringData.pollTitle,
                            color: AppColors.greyBlackColor,
                          )
                        ],
                      ),
                    );
                  }),

              const SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          nbrVoters = nbrVoters * 2;
                        });
                      },
                      child: Row(
                        children: [
                          AppText(
                            StringData.showMore,
                            color: AppColors.blueBgColor,
                            size: 12.0,
                            weight: FontWeight.bold,
                          ),
                          Icon(
                            Icons.expand_more,
                            color: AppColors.blueBgColor,
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
