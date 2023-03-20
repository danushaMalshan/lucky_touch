import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/api_key_model.dart';
import 'package:lucky_touch/beanResponse/ticket_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelGoldenTicketScreen extends ChangeNotifier {
  TicketModel? _model;
  ApiKeyModel? _apiModel;
  bool _progress = false;
  bool _dataLoading = false;

  bool get progress => _progress;

  ApiKeyModel? get apiModel {
    return _apiModel;
  }

  TicketModel? get model {
    return _model;
  }

  bool get dataLoading => _dataLoading;

  progressChange(bool value) {
    _progress = value;
    notifyListeners();
  }

  getTickets() async {
    _dataLoading = true;

    _progress = true;

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getTickets('0');
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _model = TicketModel.fromJson(parsed);
    _dataLoading = false;

    _progress = false;
    await getApiKey();
    notifyListeners();
    return _model;
  }

  getApiKey() async {
    _dataLoading = true;

    _progress = true;

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getApiKey();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _apiModel = ApiKeyModel.fromJson(parsed);
    _dataLoading = false;

    _progress = false;

    notifyListeners();
  }
}
