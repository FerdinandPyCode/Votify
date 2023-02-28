import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/models/vote_model.dart';
import 'package:votify_2/app/core/utils/providers.dart';

class VoteController {
  Ref ref;
  VoteController(this.ref);

  Future<void> addVote(Vote vote) async {
    await ref.read(voteRef).add(vote.toMap());
  }

  Stream<Map<String, List<Vote>>> getAllVote() {
    return ref.read(voteRef).snapshots().map((event) {
      List<Vote> es = event.docs
          .map((e) =>
              Vote.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id))
          .toList();

      Map<String, List<Vote>> votes = {"PRIVATE": [], "PUBLIC": []};
      for (Vote v in es) {
        if (v.electionType == "PUBLIC") {
          votes['PUBLIC']!.add(v);
        } else {
          if (v.votersEmail.contains(ref.read(userAuth).me.email)) {
            votes['PRIVATE']!.add(v);
          }
        }
      }
      return votes;
    });
  }

  Future<List<Vote>> getAllVoteFuture() async {
    List<Vote> es = [];
    await ref.read(voteRef).get().then((event) {
      for (var e in event.docs) {
        es.add(
            Vote.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id));
      }
    });
    return es;
  }

  Future<Vote> getVote(String id) async {
    Vote en = Vote.initial();
    await ref.read(voteRef).doc(id).get().then((e) {
      en = Vote.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id);
    });
    return en;
  }
}
