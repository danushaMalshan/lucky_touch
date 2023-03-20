import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelBottomNavigationBar extends ChangeNotifier{

  int _index = 2;

  void changeIndex(int index){
    _index=index;
    notifyListeners();
  }

  int get index=>_index;
}