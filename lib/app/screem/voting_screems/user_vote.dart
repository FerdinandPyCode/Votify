// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/strings.dart';
import 'package:votify_2/app/core/generated/dynamique_button.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/models/vote_model.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/providers.dart';
import 'package:votify_2/app/screem/home_screem/home_screem.dart';

import '../../core/constants/color.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/app_input_end_text_widget/bottom_navigation.dart';
import '../../core/generated/widgets/dial_button.dart';

class UserVoteTemplate extends ConsumerStatefulWidget {
  final Vote vote;
  const UserVoteTemplate(this.vote, {super.key});

  @override
  ConsumerState<UserVoteTemplate> createState() => _UserVoteTemplateState();
}

class _UserVoteTemplateState extends ConsumerState<UserVoteTemplate> {
  late int selectedRadioTile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
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
                    '${widget.vote.listeVote.length} ${StringData.alreadyVpters}',
                    color: AppColors.blackColor,
                    size: 15.0,
                    weight: FontWeight.bold,
                  )
                ],
              ),
              Center(child: Image.asset(AssetData.fleche)),
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
                  itemBuilder: (context, int index) {
                    return RadioListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      value: index,
                      groupValue: selectedRadioTile,
                      onChanged: (val) {
                        setSelectedRadioTile(val!);
                      },
                      title: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: AppColors.greySkyColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: AppColors.greyColor)),
                        width: double.infinity,
                        height: 40.0,
                        child: Center(
                          child: AppText(
                            widget.vote.listeOptions[index].fullName,
                            color: AppColors.greyBlackColor,
                            size: 13.0,
                          ),
                        ),
                      ),
                    );
                  }),

              const SizedBox(
                height: 16.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //delete button
                  widget.vote.creator == ref.read(userAuth).userId
                      ? DynamiqueButton(
                          childs: Center(
                              child: AppText(
                            StringData.delete,
                            color: AppColors.backgroundColor,
                            size: 12.0,
                          )),
                          width: 100,
                          height: 40,
                          action: () {},
                          bgColor: AppColors.redColor,
                          radius: 10)
                      : const Center(),

                  //Vote button
                  DynamiqueButton(
                      childs: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLoading
                              ? CupertinoActivityIndicator(
                                  radius: 10,
                                  color: AppColors.backgroundColor,
                                )
                              : AppText(
                                  StringData.vote,
                                  color: AppColors.backgroundColor,
                                  size: 12.0,
                                ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Image.asset(
                            AssetData.go,
                            color: AppColors.backgroundColor,
                          )
                        ],
                      ),
                      width: 100,
                      height: 40,
                      action: () async {
                        logd(selectedRadioTile);
                        logd(widget.vote.id);
                        setState(() {
                          isLoading = true;
                        });
                        await ref.read(voteController).voteNow(widget.vote.id,
                            "OPT${selectedRadioTile + 1}", widget.vote);

                        setState(() {
                          isLoading = false;
                        });
                        Fluttertoast.showToast(
                            msg: "Vote vote a été éffectué avec succès !");
                        navigateToNextPage(context, const MyHomeScreem(),
                            back: false);
                      },
                      bgColor: AppColors.blueBgColor,
                      radius: 10)
                ],
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
}
