import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/chat_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelChats extends ChangeNotifier {
  ChatModel? _model;

  bool _progress = false;
  bool _dataLoading = false;
final ScrollController _controller = ScrollController();
  bool get progress => _progress;

  ChatModel? get model {
    return _model;
  }
 ScrollController get controller{
  return _controller;
 }
  bool get dataLoading => _dataLoading;

   

  getChats() async {
    _dataLoading = true;

    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getChats();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _model = ChatModel.fromJson(parsed);
    _dataLoading = false;

    notifyListeners();
    return _model;
  }

  sendMessage(usersId,String msg, isSender) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.AddTickets(usersId,msg, isSender);
    if (res == null) return;

   await getChats();

  //  _scrollDown();

    notifyListeners();
  }

  updateChattedUsers(String msg)async{
     Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.updateChattedUser(msg);
    if (res == null) return;
  }
}
