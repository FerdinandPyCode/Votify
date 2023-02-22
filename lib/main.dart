import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/core/providers.dart/auth.dart';
import 'app/screem/log_sign_screem/activation_compte.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProxyProvider<Auth, Auth>(
            update: (context, auth, previosNote) => Auth(),
            create: (ctx) => Auth(),
          ),
        ],
        child: ConfirmationCodePage(), //const CreatePrivatePoll() ,
      ),
    );
  }
}
