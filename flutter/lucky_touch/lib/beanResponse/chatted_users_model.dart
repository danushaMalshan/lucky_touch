///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ChattedUserModelData {
/*
{
  "users_id": 3,
  "first_name": "danu",
  "last_name": "malshan",
  "profile_pic": "",
  "country": "sri lanka",
  "usdt_address": "dfxddf",
  "email": "dan.malshan@gmail.com",
  "password": "$2a$08$FYiVDcuA6a7/4Ur8OHBD8e7fLQZGE0POhCbMS9KLHgyAP7sF.Tnie",
  "ticket_count": 4,
  "last_online": "2022-09-13T13:16:43.000Z",
  "is_admin": 1,
  "chatted": 1,
  "last_msg": "Hi",
  "last_msg_time": "2022-09-13T12:31:35.000Z",
  "msg_seen": 0,
  "createdAt": "2022-08-03T16:33:12.000Z",
  "updatedAt": "2022-09-13T13:16:42.000Z"
} 
*/

  int? usersId;
  String? firstName;
  String? lastName;
  String? profilePic;
  String? country;
  String? usdtAddress;
  String? email;
  String? password;
  int? ticketCount;
  String? lastOnline;
  int? isAdmin;
  int? chatted;
  String? lastMsg;
  String? lastMsgTime;
  int? msgSeen;
  String? createdAt;
  String? updatedAt;

  ChattedUserModelData({
    this.usersId,
    this.firstName,
    this.lastName,
    this.profilePic,
    this.country,
    this.usdtAddress,
    this.email,
    this.password,
    this.ticketCount,
    this.lastOnline,
    this.isAdmin,
    this.chatted,
    this.lastMsg,
    this.lastMsgTime,
    this.msgSeen,
    this.createdAt,
    this.updatedAt,
  });
  ChattedUserModelData.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id']?.toInt();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    profilePic = json['profile_pic']?.toString();
    country = json['country']?.toString();
    usdtAddress = json['usdt_address']?.toString();
    email = json['email']?.toString();
    password = json['password']?.toString();
    ticketCount = json['ticket_count']?.toInt();
    lastOnline = json['last_online']?.toString();
    isAdmin = json['is_admin']?.toInt();
    chatted = json['chatted']?.toInt();
    lastMsg = json['last_msg']?.toString();
    lastMsgTime = json['last_msg_time']?.toString();
    msgSeen = json['msg_seen']?.toInt();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['users_id'] = usersId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_pic'] = profilePic;
    data['country'] = country;
    data['usdt_address'] = usdtAddress;
    data['email'] = email;
    data['password'] = password;
    data['ticket_count'] = ticketCount;
    data['last_online'] = lastOnline;
    data['is_admin'] = isAdmin;
    data['chatted'] = chatted;
    data['last_msg'] = lastMsg;
    data['last_msg_time'] = lastMsgTime;
    data['msg_seen'] = msgSeen;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ChattedUserModel {
/*
{
  "data": [
    {
      "users_id": 3,
      "first_name": "danu",
      "last_name": "malshan",
      "profile_pic": "",
      "country": "sri lanka",
      "usdt_address": "dfxddf",
      "email": "dan.malshan@gmail.com",
      "password": "$2a$08$FYiVDcuA6a7/4Ur8OHBD8e7fLQZGE0POhCbMS9KLHgyAP7sF.Tnie",
      "ticket_count": 4,
      "last_online": "2022-09-13T13:16:43.000Z",
      "is_admin": 1,
      "chatted": 1,
      "last_msg": "Hi",
      "last_msg_time": "2022-09-13T12:31:35.000Z",
      "msg_seen": 0,
      "createdAt": "2022-08-03T16:33:12.000Z",
      "updatedAt": "2022-09-13T13:16:42.000Z"
    }
  ]
} 
*/

  List<ChattedUserModelData?>? data;

  ChattedUserModel({
    this.data,
  });
  ChattedUserModel.fromJson(Map<String, dynamic> json) {
  if (json['data'] != null) {
  final v = json['data'];
  final arr0 = <ChattedUserModelData>[];
  v.forEach((v) {
  arr0.add(ChattedUserModelData.fromJson(v));
  });
    this.data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['data'] = arr0;
    }
    return data;
  }
}
