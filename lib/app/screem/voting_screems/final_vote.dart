import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/strings.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/models/options_model.dart';
import 'package:votify_2/app/core/models/user_model.dart';
import 'package:votify_2/app/core/models/user_vote_model.dart';
import 'package:votify_2/app/core/models/vote_model.dart';
import 'package:votify_2/app/core/utils/providers.dart';

import '../../core/constants/color.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';

class FinalVoteTemplate extends ConsumerStatefulWidget {
  final Vote vote;
  const FinalVoteTemplate(this.vote, {super.key});

  @override
  ConsumerState<FinalVoteTemplate> createState() => _FinalVoteTemplateState();
}

class _FinalVoteTemplateState extends ConsumerState<FinalVoteTemplate> {
  int nbrVoters = 0;
  String codeOpt = "OPT1";
  Map<String, int> proportionVotes = {};
  @override
  void initState() {
    nbrVoters = widget.vote.listeVote.length;
    getSelected();
    super.initState();
  }

  void getSelected() {
    for (Option opt in widget.vote.listeOptions) {
      proportionVotes[opt.code] = 0;
    }
    int som = 0;
    for (UserVote uV in widget.vote.listeVote) {
      if (uV.userId == ref.read(userAuth).userId) {
        codeOpt = uV.optionchoisi;
      }
      proportionVotes[uV.optionchoisi] = proportionVotes[uV.optionchoisi]! + 1;
      som += 1;
    }
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
                              (codeOpt == widget.vote.listeOptions[index].code)
                                  ? Image.asset(
                                      AssetData.valide,
                                      color: AppColors.blueBgColor,
                                    )
                                  : const AppText(''),
                              const SizedBox(
                                width: 5.0,
                              ),

                              (DateTime.parse(widget.vote.dateEnd)
                                              .millisecondsSinceEpoch >
                                          DateTime.now()
                                              .millisecondsSinceEpoch ||
                                      widget.vote.electionType == "PUBLIC" ||
                                      widget.vote.creator ==
                                          ref.read(userAuth).userId)
                                  ? AppText(
                                      (((proportionVotes[widget
                                                      .vote
                                                      .listeOptions[index]
                                                      .code]!) /
                                                  (widget
                                                      .vote.listeVote.length)) *
                                              100)
                                          .ceil()
                                          .toString(),
                                      weight: FontWeight.bold,
                                      color: AppColors.blueBgColor,
                                      size: 20.0,
                                    )
                                  : const AppText("")
                              //: const AppText(""),
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
              widget.vote.creator == ref.read(userAuth).userId
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: ref
                                .read(voteController)
                                .getVoteUser(widget.vote.listeVote),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<UserModel> liste = snapshot.data ?? [];
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: liste.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            color: AppColors.backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                              backgroundColor:
                                                  AppColors.greySkyColor,
                                              backgroundImage:
                                                  AssetImage(AssetData.google),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            AppText(
                                              liste[index].username,
                                              color: AppColors.greyBlackColor,
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              } else if (snapshot.hasError) {
                                return const AppText(
                                    "Une erreur lors de la récupération de la liste des votants");
                              } else {
                                return const CircularProgressIndicator();
                              }
                            }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: TextButton(
                                // onPressed: () {
                                //   setState(() {
                                //     nbrVoters = nbrVoters * 2;
                                //   });
                                // },
                                onPressed: null,
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
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: AppText(
                          "Veuillez contacter le créateur du vote pour avoir plus de détail"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
