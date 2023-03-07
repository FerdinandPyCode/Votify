import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/models/notif_model.dart';
import 'package:votify_2/app/core/models/user_model.dart';
import 'package:votify_2/app/core/models/user_vote_model.dart';
import 'package:votify_2/app/core/models/vote_model.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/providers.dart';

class VoteController {
  Ref ref;
  VoteController(this.ref);

  Future<void> addVote(Vote vote) async {
    await ref.read(voteRef).add(vote.toMap());

    if (vote.electionType == 'PRIVATE') {
      for (String mail in vote.votersEmail) {
        NotifModel nM = NotifModel(
            key: '',
            title: 'Nouveau Vote Créé pour vous',
            description: "Nouveau vote pour vous, passez à l'action !",
            createdAt: DateTime.now().toString().substring(0, 19),
            to: mail,
            from: ref.read(userAuth).me.email,
            type: "NEW VOTE",
            seen: 0);
        await ref.read(notifController).sendNotif(nM);
      }
    }
  }

  Stream<Map<String, List<Vote>>> getAllVote() {
    return ref.read(voteRef).snapshots().map((event) {
      List<Vote> es = event.docs
          .map((e) =>
              Vote.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id))
          .toList();

      Map<String, List<Vote>> votes = {"PRIVATE": [], "PUBLIC": []};
      for (Vote v in es) {
        if (DateTime.parse(v.dateEnd).millisecondsSinceEpoch >
            DateTime.now().millisecondsSinceEpoch) {
          bool can = true;

          for (UserVote uV in v.listeVote) {
            if (uV.userId == ref.read(userAuth).userId) {
              can = false;
              break;
            }
          }
          if (can) {
            if (v.electionType == "PUBLIC") {
              votes['PUBLIC']!.add(v);
            } else {
              if (v.votersEmail.contains(ref.read(userAuth).me.email)) {
                votes['PRIVATE']!.add(v);
              }
            }
          }
        }
      }
      return votes;
    });
  }

  Future<List<Vote>> getAllVoteFuture() async {
    List<Vote> es = [];
    List<Vote> votes = [];

    await ref.read(voteRef).get().then((event) {
      for (var e in event.docs) {
        es.add(
            Vote.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id));
      }
    });
    for (Vote v in es) {
      if (DateTime.parse(v.dateState).millisecondsSinceEpoch <
          DateTime.now().millisecondsSinceEpoch) {
        if (v.electionType == "PUBLIC") {
          votes.add(v);
        } else {
          if (v.votersEmail.contains(ref.read(userAuth).me.email)) {
            votes.add(v);
          }
        }
      }
    }
    return votes;
  }

  Future<List<UserModel>> getVoteUser(List<UserVote> lUV) async {
    List<UserModel> liste = [];
    for (UserVote uV in lUV) {
      await ref.read(userController).getUser(uV.userId).then((value) {
        liste.add(value);
      });
    }

    return liste;
  }

  Future<void> voteNow(String voteId, String option, Vote vote) async {
    await ref.read(voteRef).doc(voteId).update({
      "listeVote": FieldValue.arrayUnion([
        {
          'userId': ref.read(userAuth).userId,
          'optionchoisi': option,
          'votedAt': DateTime.now().toString().substring(0, 19)
        }
      ])
    });
    logd("--------------------------");
    logd(vote.creator);
    logd("--------------------------");
    UserModel userModel = await ref.read(userController).getUser(vote.creator);
    NotifModel m = NotifModel(
        key: '',
        title: "Nouveau votant",
        description:
            "${vote.title} a été voté par ${ref.read(userAuth).me.username}",
        createdAt: DateTime.now().toString().substring(0, 19),
        to: userModel.email,
        from: ref.read(userAuth).me.email,
        type: "NewVote",
        seen: 0);
    await ref.read(notifController).sendNotif(m);
  }

  Stream<Map<String, List<Vote>>> getOldVote() {
    return ref.read(voteRef).snapshots().map((event) {
      List<Vote> es = event.docs
          .map((e) =>
              Vote.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id))
          .toList();

      Map<String, List<Vote>> votes = {"PRIVATE": [], "PUBLIC": []};
      for (Vote v in es) {
        bool can = true;

        for (UserVote uV in v.listeVote) {
          if (uV.userId == ref.read(userAuth).userId) {
            can = false;
            break;
          }
        }
        if (!can) {
          if (v.electionType == "PUBLIC") {
            votes['PUBLIC']!.add(v);
          } else {
            if (v.votersEmail.contains(ref.read(userAuth).me.email)) {
              votes['PRIVATE']!.add(v);
            }
          }
        }
      }
      return votes;
    });
  }
}
