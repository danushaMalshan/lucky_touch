import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucky_touch/beanResponse/chat_model.dart';
import 'package:lucky_touch/beanResponse/chatted_users_model.dart';
import 'package:lucky_touch/webservice/servicewrapper.dart';

class ModelAdminChats extends ChangeNotifier {
  ChattedUserModel? _model;
  ChatModel? _chatModel;
  final ScrollController _controller = ScrollController();

  ChattedUserModel? get model {
    return _model;
  }

  ChatModel? get chatModel {
    return _chatModel;
  }

  ScrollController get controller {
    return _controller;
  }


  getChattedUsers() async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getChattedUsers();
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _model = ChattedUserModel.fromJson(parsed);

    notifyListeners();
    return _model;
  }

  getUsersChats(int id) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.getUserChats(id);
    if (res == null) return;
    final Map<String, dynamic> parsed = res;
    _chatModel = ChatModel.fromJson(parsed);

    await updateMsgSeen(id);
    await getChattedUsers();
    notifyListeners();
    return _chatModel;
  }

  sendMessage(int usersId, String msg, isSender) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.AddTickets(usersId, msg, isSender);
    if (res == null) return;

    await getUsersChats(usersId);

    //  _scrollDown();

    notifyListeners();
  }

  updateMsgSeen(int id) async {
    Servicewrapper wrapper = new Servicewrapper();
    var res = await wrapper.updateMsgSeen(id);
    if (res == null) return;
  }
}
