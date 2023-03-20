

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelAddTickets extends ChangeNotifier{

  bool _goldProgress = false;
  bool _silverProgress = false;
  bool _platinumProgress = false;
 

  
  void changeGoldTicketsStatus(bool value){
    _goldProgress=value;
    notifyListeners();
  }
  void changeSilverTicketsStatus(bool value){
    _silverProgress=value;
    notifyListeners();
  }
  
  void changePlatinumTicketsStatus(bool value){
    _platinumProgress=value;
    notifyListeners();
  }
  
  


  bool get gold_progress=>_goldProgress;
   bool get silver_progress=>_silverProgress;
    bool get platinum_progress=>_platinumProgress;
 
}