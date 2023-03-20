import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lucky_touch/beanResponse/new_users_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelNewUsers extends ChangeNotifier {
  NewUsersModel? _model;

  NewUsersModel? get model {
    return _model;
  }

  getOnlineUsers() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getNewUsers();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _model = NewUsersModel.fromJson(parsed);
   notifyListeners();
    return _model;
  }
}
