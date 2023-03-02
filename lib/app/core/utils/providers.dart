import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/constants/conf.dart';
import 'package:votify_2/app/core/controller/notif_controller.dart';
import 'package:votify_2/app/core/controller/user_controller.dart';
import 'package:votify_2/app/core/controller/vote_controller.dart';
import 'package:votify_2/app/core/services/dio_client.dart';

final dio = Provider(
    (ref) => DioClient(ConfString.BASE_URL, ref.watch(userAuth).token));

Provider<FirebaseAuth> mAuthRef = Provider((ref) => getFirebaseAuth());
final messaging =
    Provider<FirebaseMessaging>((ref) => FirebaseMessaging.instance);
final thumbStorageRef =
    Provider<Reference>((ref) => FirebaseStorage.instance.ref());

Provider<CollectionReference> userRef =
    Provider((ref) => getFirestore().collection("Users"));
Provider<CollectionReference> voteRef =
    Provider((ref) => getFirestore().collection("Votes"));
Provider<CollectionReference> notifRef =
    Provider((ref) => getFirestore().collection("notifications"));
// Provider<CollectionReference> catRef = Provider((ref) => getFirestore().collection("Categories"));
// Provider<CollectionReference> catUsersRef = Provider((ref) => getFirestore().collection("CategoriesUsers"));
// Provider<CollectionReference> livreRef = Provider((ref) => getFirestore().collection("Livres"));
// Provider<CollectionReference> postRef = Provider((ref) => getFirestore().collection("Posts"));
// Provider<CollectionReference> favRef = Provider((ref) => getFirestore().collection("Favoris"));
// Provider<CollectionReference> followRef = Provider((ref) => getFirestore().collection("Followers"));
// Provider<CollectionReference> notifRef = Provider((ref) => getFirestore().collection("Notifications"));
// Provider<CollectionReference> commentRef = Provider((ref) => getFirestore().collection("Commentaires"));

final userAuth = ChangeNotifierProvider<UserAuth>((ref) => UserAuth());
final userController = Provider((ref) => UserController(ref));
final voteController = Provider<VoteController>((ref) => VoteController(ref));
final notifController =
    Provider<NotifController>((ref) => NotifController(ref));

// final mainController = Provider<MainController>((ref) => MainController(ref));
// final livreController = Provider<LivreController>((ref) => LivreController(ref));
// final catController = Provider<CategoryController>((ref) => CategoryController(ref));
// final postController = Provider<PostController>((ref) => PostController(ref));
// final favController = Provider<FavController>((ref) => FavController(ref));
// final followController = Provider<FollowController>((ref) => FollowController(ref));
// final reviewAppController = Provider<ReviewAppController>((ref) => ReviewAppController(ref));
// final notifController = Provider<NotifController>((ref) => NotifController(ref));
// final commentController = Provider<CommentaireController>((ref) => CommentaireController(ref));

FirebaseFirestore getFirestore() {
  return FirebaseFirestore.instance;
}

getFirebaseAuth() {
  return FirebaseAuth.instance;
}
