import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/get_last_round_model.dart';
import 'package:lucky_touch/beanResponse/get_winners_model.dart';

import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelWinnersScreen extends ChangeNotifier {
  GetWinnersModel? _model;
  GetLastRound? _lastRoundModel;
  bool _progress = false;
  bool _dataLoading = false;

  bool get progress => _progress;

  GetWinnersModel? get model {
    return _model;
  }

  GetLastRound? get lastRoundModel {
    return _lastRoundModel;
  }

  bool get dataLoading => _dataLoading;

  getWinners() async {
    _dataLoading = true;

    _progress = true;

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getWinners();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _model = GetWinnersModel.fromJson(parsed);
    _dataLoading = false;

    _progress = false;
    await _getRounds();
    notifyListeners();
    return _model;
  }

  _getRounds() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getLastRound();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _lastRoundModel = GetLastRound.fromJson(parsed);

    notifyListeners();
    return model;
  }
}
