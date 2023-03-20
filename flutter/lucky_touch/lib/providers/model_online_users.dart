import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lucky_touch/beanResponse/online_users_model.dart';

import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelOnlineUsers extends ChangeNotifier {
  OnlineUsersModel? _model;

  OnlineUsersModel? get model {
    return _model;
  }

  getOnlineUsers() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getOnlineUsers();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _model = OnlineUsersModel.fromJson(parsed);
   notifyListeners();
    return _model;
  }
}
