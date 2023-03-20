

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelCustomTicket extends ChangeNotifier {
  bool _goingtoExpire = false;

  void changeExpireStatus(bool value) {
    _goingtoExpire = value;
    notifyListeners();
  }

  bool get goingtoExpire => _goingtoExpire;
}
