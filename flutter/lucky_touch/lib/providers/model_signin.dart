

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelSignIn extends ChangeNotifier{

  bool _progress = false;
 

  
  void changeProgressState(bool value){
    _progress=value;
    notifyListeners();
  }
  


  bool get progress=>_progress;
 
}