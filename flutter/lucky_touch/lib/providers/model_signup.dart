import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelSignUp extends ChangeNotifier{

  File? _image;
  bool _progress = false;

  void changeImage(File? image){
    _image=image;
    notifyListeners();
  }
  void changeProgressState(bool value){
    _progress=value;
    notifyListeners();
  }
  

  File? get image=> _image;
  bool get progress=>_progress;
 
}