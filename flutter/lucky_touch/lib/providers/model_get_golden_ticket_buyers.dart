import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/get_ticket_buyers_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelGetGoldenTicketBuyers extends ChangeNotifier {
  GetTicketBuyersModel? _model;
  bool _progress = false;
  bool _dataLoading = false;
  bool get progress => _progress;

  GetTicketBuyersModel? get model {
    return _model;
  }

  bool get dataLoading => _dataLoading;

  getTicketBuyers() async {
    _dataLoading = true;

    _progress = true;

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getTicketBuyers(0);
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _model = GetTicketBuyersModel.fromJson(parsed);

     for (var i = 0; i < (model?.data?.length ?? 0); i++) {
      await _showPayment(model?.data?[i]?.paymentId ?? '');
      // await _updateTimeline(model?.data?[i]?.buyerId ?? 0,
      //     _showPaymentModel?.data?.timeline?.last?.status ?? '');
    }
var res2 = await wrapper.getTicketBuyers(0);
    if (res == null) return;
    final Map<String, dynamic> parsed2 = res2;
    _model = GetTicketBuyersModel.fromJson(parsed2);
    _dataLoading = false;

    _progress = false;

    notifyListeners();
    return _model;
  }
progressChange(bool value) {
    _progress = value;
    notifyListeners();
  }
  _showPayment(String paymentId) async {
    _dataLoading = true;

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.showAPayment(paymentId);
    if (res == null) return;
    _dataLoading = false;
  }


}
