import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmationCodePage extends StatefulWidget {
  const ConfirmationCodePage({super.key});

  @override
  _ConfirmationCodePageState createState() => _ConfirmationCodePageState();
}

class _ConfirmationCodePageState extends State<ConfirmationCodePage> {
  String _pinCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Entrez le code de confirmation à quatre chiffres"),
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
                  setState(() {
                    _pinCode = value;
                  });
                },
                appContext: (context),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Confirmer"),
                onPressed: () {
                  if (_pinCode.length == 4) {
                    // Validation du code de confirmation
                    // Faire quelque chose
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
