

import 'dart:developer';

import 'package:flutter/foundation.dart';

class BaseProvider with ChangeNotifier {
  final String className;

  BaseProvider(this.className);
  bool _dispoded = false;

  @override
  void notifyListeners() {
    if (_dispoded) {
      log("$className is disposed", name: className);
    }
    else{
    super.notifyListeners();

    }
  }

  @override
  void dispose() {
    _dispoded = true;
    super.dispose();
  }
}
