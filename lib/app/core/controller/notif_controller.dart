import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/models/notif_model.dart';
import 'package:votify_2/app/core/utils/providers.dart';

class NotifController {
  Ref ref;
  NotifController(
    this.ref,
  );

  Future<void> sendNotif(NotifModel model) async {
    if (model.to == ref.read(userAuth).userId) {
      return;
    }
    await ref.read(notifRef).add(model.toMap());
  }

  // Stream<List<NotifModel>> getNotifs(String nUid) {
  //   ref.read(notifRef).doc(nUid).snapshots().map((event) {
  //     List<NotifModel> es = event.docs
  //         .map((e) => NotifModel.fromMap(e.data() as Map<String, dynamic>)
  //             .copyWith(key: e.id))
  //         .toList();
  //     return es;
  //   });
  // }

  Stream<List<NotifModel>> myNotifs() {
    return ref
        .read(notifRef)
        .where("to", isEqualTo: ref.read(userAuth).userId)
        .orderBy("createdAt", descending: true)
        .limitToLast(30)
        .snapshots()
        .map((event) {
      List<NotifModel> es = [];
      for (var e in event.docs) {
        NotifModel f = NotifModel.fromMap(e.data() as Map<String, dynamic>)
            .copyWith(key: e.id);
        es.add(f);
      }
      return es;
    });
  }

  // Future<void> treatNotif(BuildContext context, NotifModel data) async {
  //   if (data.type == NotifType.profile.toString()) {
  //     navigateToNextPageWithTransition(
  //         context, ProfilePage(profileId: data.mainKey));
  //   } else if (data.type == NotifType.book.toString()) {
  //     Livre livre = await ref.read(livreController).getLivre(data.mainKey);
  //     navigateToNextPageWithTransition(context, SingleBook(livre));
  //   } else if (data.type == NotifType.post.toString()) {
  //     AgentPost post = await ref
  //         .read(postController)
  //         .getPostAgents(await ref.read(postController).getPost(data.mainKey));
  //     navigateToNextPageWithTransition(context, SinglePost(post));
  //   }
  // }

  // markView() async {
  //   List<NotifModel> notifs = [];
  //   await ref
  //       .read(notifRef)
  //       .where("to", isEqualTo: ref.read(me).userId)
  //       .where("isSeen", isEqualTo: false)
  //       .get()
  //       .then((value) {
  //     for (var element in value.docs) {
  //       notifs.add(NotifModel.fromMap(element.data() as Map<String, dynamic>)
  //           .copyWith(key: element.id));
  //     }
  //   });
  //   notifs = notifs.where((element) => !element.isSeen).toList();
  //   WriteBatch batch = getFirestore().batch();
  //   for (var element in notifs) {
  //     batch.update(ref.read(notifRef).doc(element.key), {'isSeen': true});
  //   }
  //   await batch.commit();
  // }
}
