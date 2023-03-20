import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/all_users_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelAllUsers extends ChangeNotifier {
  AllUsersModel? _model;

  AllUsersModel? get model {
    return _model;
  }

  getAllUsers(String query) async {
    print('step 1');
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getAllUsers(query);
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _model = AllUsersModel.fromJson(parsed);
    notifyListeners();
    return _model;
  }
}
