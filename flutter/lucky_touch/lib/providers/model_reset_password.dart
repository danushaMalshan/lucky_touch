

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelResetPassword extends ChangeNotifier{

  bool _progress = false;
  bool _sendCode=false;

  
  void changeProgressState(bool value){
    _progress=value;
    notifyListeners();
  }

  void changesendCodeState(bool value){
    _sendCode=value;
    notifyListeners();
  }
  


  bool get progress=>_progress;
  bool get sendCode=>_sendCode;
 
}