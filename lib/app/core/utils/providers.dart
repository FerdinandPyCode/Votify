import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votify_2/app/core/constants/conf.dart';
import 'package:votify_2/app/core/controller/user_controller.dart';
import 'package:votify_2/app/core/services/dio_client.dart';

final dio =
    Provider((ref) => DioClient(ConfString.BASE_URL, ref.read(userAuth).token));
final userAuth = ChangeNotifierProvider<UserAuth>((ref) => UserAuth());

final userController = Provider((ref) => UserController(ref));
