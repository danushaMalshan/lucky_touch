import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/show_payment_model.dart';
import 'package:lucky_touch/util/local_base.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelMyTickets extends ChangeNotifier {
  ShowPaymentModel? _showPaymentModel;
  bool _progress = false;
  bool _dataLoading = false;

  bool get progress => _progress;

  // UserTicketModel? get model {
  //   return _model;
  // }

  ShowPaymentModel? get showPaymentModel {
    return _showPaymentModel;
  }

  bool get dataLoading => _dataLoading;

  // getTickets() async {
  //   _dataLoading = true;

  //   _progress = true;

  //   Servicewrapper wrapper = new Servicewrapper();
  //   var res = await wrapper.getUserTickets();
  //   if (res == null) return;
  //   final Map<String, dynamic> parsed = res;
  //   _model = UserTicketModel.fromJson(parsed);
  //   _dataLoading = false;

  //   _progress = false;
  //   notifyListeners();
  //   return _model;
  // }

   getTimeline(paymentId) async {
    String? timeline = await LocalRepo().getTimeline(paymentId);
print(timeline);
    return timeline;
    
  }

  showPayment(String paymentId) async {
    _dataLoading = true;

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.showAPayment(paymentId);
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _showPaymentModel = ShowPaymentModel.fromJson(parsed);
    _dataLoading = false;

    LocalRepo().setTimeline(paymentId,
        _showPaymentModel?.data?.timeline?.last?.status ?? 'WAITING');

    // notifyListeners();
  }
}
