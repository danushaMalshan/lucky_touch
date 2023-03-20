import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/ban_users_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelBanUsers extends ChangeNotifier {
  BanUsersModel? _model;

  BanUsersModel? get model {
    return _model;
  }

  getBanUsers() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getBanUsers();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _model = BanUsersModel.fromJson(parsed);
   notifyListeners();
    return _model;
  }
}
