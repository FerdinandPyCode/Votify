import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/models/user_vote_model.dart';
import 'package:votify_2/app/core/models/vote_model.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/providers.dart';
import 'package:votify_2/app/screem/voting_screems/final_vote.dart';
import 'package:votify_2/app/screem/voting_screems/user_vote.dart';

import '../../core/constants/color.dart';
import '../../core/constants/strings.dart';
import '../../core/generated/widgets/app_input_end_text_widget/app_text.dart';
import '../../core/generated/my_app_bar.dart';
import '../../core/generated/widgets/dial_button.dart';
import '../../core/generated/widgets/polls_container.dart';
import '../../core/generated/widgets/search_widget.dart';

class SearchVoteResult extends ConsumerStatefulWidget {
  const SearchVoteResult({super.key});

  @override
  ConsumerState<SearchVoteResult> createState() => _SearchVoteResultState();
}

class _SearchVoteResultState extends ConsumerState<SearchVoteResult> {
  TextEditingController searchController = TextEditingController();
  List<Vote> liste = [];

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
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Search widgets
              SearchWidget(
                action: () {},
                onChanged: searchVote,
                controller: searchController,
                hintText: StringData.which,
                here: 1,
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
              //--------------------------------------------
              Expanded(
                child: liste.isNotEmpty
                    ? listOfResults(liste)
                    : ref.watch(fetchAllVote).when(
                        data: ((data) {
                          setState(() {
                            liste = data;
                          });
                          if (data.isEmpty) {
                            return const Center(
                              child: Text("Aucune donnée trouvée..."),
                            );
                          }
                          return listOfResults(data);
                        }),
                        error: (err, stackErr) {
                          logd(stackErr);
                          return const Text("Une erreur est survenue ");
                        },
                        loading: (() => const Center(
                              child: CircularProgressIndicator(),
                            ))),
              ),
            ],
          )),
    );
  }

  void searchVote(String querry) {
    if (querry.trim().isEmpty) {
      setState(() {
        liste = [];
      });
      return;
    }

    final suggestions = ref.read(fetchAllVote).value!.where((vote) {
      final input = querry.trim().toLowerCase();
      final voteTitle = vote.title.toLowerCase();
      logd(voteTitle);
      return voteTitle.contains(input);
    }).toList();

    setState(() {
      liste = suggestions;
    });
  }

  Widget listOfResults(List<Vote> votes) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return PollsWidgets.pollSecondeTemplate(
            nbrOptions: votes[index].listeOptions.length.toString(),
            nbrVotes: votes[index].listeVote.length.toString(),
            title: votes[index].title,
            action: () {
              bool can = true;

              for (UserVote uV in votes[index].listeVote) {
                if (uV.userId == ref.read(userAuth).userId) {
                  can = false;
                  break;
                }
              }

              if (can) {
                navigateToNextPage(context, UserVoteTemplate(votes[index]));
              } else {
                navigateToNextPage(context, FinalVoteTemplate(votes[index]));
              }
            });
      },
      shrinkWrap: true,
      itemCount: votes.length,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: getSize(context).width * 0.04, vertical: 1),
          height: 0,
          color: Colors.grey,
        );
      },
    );
  }
}
