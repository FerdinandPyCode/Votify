import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';
import 'package:votify_2/app/core/models/user_model.dart';
import 'package:votify_2/app/core/utils/app_func.dart';
import 'package:votify_2/app/core/utils/providers.dart';
import 'package:votify_2/app/screem/log_sign_screem/login.dart';

class ConfirmationCodePage extends ConsumerStatefulWidget {
  UserModel userModel;

  ConfirmationCodePage({super.key, required this.userModel});

  @override
  _ConfirmationCodePageState createState() => _ConfirmationCodePageState();
}

class _ConfirmationCodePageState extends ConsumerState<ConfirmationCodePage> {
  String _pinCode = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  "Entrez le code de confirmation à quatre chiffres \nreçu par mail",
                  align: TextAlign.center,
                  color: AppColors.blackColor,
                  size: 18,
                ),
              ),
              const SizedBox(height: 20),
              PinCodeTextField(
                length: 4,
                //obsecureText: true,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.grey[200],
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                ),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    _pinCode = value;
                  });
                },
                appContext: (context),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Confirmer"),
                onPressed: () async {
                  if (_pinCode.length == 4) {
                    setState(() {
                      isLoading = true;
                    });
                    await ref
                        .read(userController)
                        .activeAccount(widget.userModel.email, _pinCode)
                        .then((value) {
                      if (value) {
                        showFlushBar(context, "Activation de compte",
                            "Compte activé avec succès !!!!!!");
                        navigateToNextPage(context, const LoginScreem(),
                            back: false);
                      } else {
                        showFlushBar(context, "Activation de compte",
                            "Erreur lors de l'activation de compte, veuillez vérifier votre code !");
                      }
                    });

                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    showFlushBar(context, "Activation de compte",
                        "Veuillez remplir tous les champs");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
