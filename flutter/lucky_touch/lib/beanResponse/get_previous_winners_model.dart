///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GetPreviousWinnersModelDataUser {
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
  "last_online": "2022-09-21T15:21:04.000Z",
  "is_admin": 1,
  "chatted": 1,
  "last_msg": "Hi",
  "last_msg_time": "2022-09-13T12:31:35.000Z",
  "msg_seen": 1,
  "createdAt": "2022-08-03T16:33:12.000Z",
  "updatedAt": "2022-09-21T15:21:04.000Z"
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

  GetPreviousWinnersModelDataUser({
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
  GetPreviousWinnersModelDataUser.fromJson(Map<String, dynamic> json) {
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

class GetPreviousWinnersModelDataTicket {
/*
{
  "ticket_id": 156906,
  "ticket_type": 0,
  "round_no": 3,
  "title": "33",
  "price": 3,
  "start_date": "2022-08-27T16:28:17.000Z",
  "expire_date": "2022-08-27T17:28:00.000Z",
  "sold": 1,
  "createdAt": "2022-08-27T16:28:17.000Z",
  "updatedAt": "2022-08-28T09:53:16.000Z"
} 
*/

  int? ticketId;
  int? ticketType;
  int? roundNo;
  String? title;
  int? price;
  String? startDate;
  String? expireDate;
  int? sold;
  String? createdAt;
  String? updatedAt;

  GetPreviousWinnersModelDataTicket({
    this.ticketId,
    this.ticketType,
    this.roundNo,
    this.title,
    this.price,
    this.startDate,
    this.expireDate,
    this.sold,
    this.createdAt,
    this.updatedAt,
  });
  GetPreviousWinnersModelDataTicket.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id']?.toInt();
    ticketType = json['ticket_type']?.toInt();
    roundNo = json['round_no']?.toInt();
    title = json['title']?.toString();
    price = json['price']?.toInt();
    startDate = json['start_date']?.toString();
    expireDate = json['expire_date']?.toString();
    sold = json['sold']?.toInt();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ticket_id'] = ticketId;
    data['ticket_type'] = ticketType;
    data['round_no'] = roundNo;
    data['title'] = title;
    data['price'] = price;
    data['start_date'] = startDate;
    data['expire_date'] = expireDate;
    data['sold'] = sold;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class GetPreviousWinnersModelData {
/*
{
  "buyer_id": 16,
  "users_id": 3,
  "ticket_id": 156906,
  "payment_id": "cd755c3c-6a35-4ab0-bbc7-d3fd3ec3c1f6",
  "timeline": "EXPIRED",
  "wallet_address": "0x297ba728acdd15ef03cc174f9d71f5dac095c19a",
  "rank": 1,
  "price": 800,
  "createdAt": "2022-08-28T09:53:16.000Z",
  "updatedAt": "2022-09-20T17:30:00.000Z",
  "ticket": {
    "ticket_id": 156906,
    "ticket_type": 0,
    "round_no": 3,
    "title": "33",
    "price": 3,
    "start_date": "2022-08-27T16:28:17.000Z",
    "expire_date": "2022-08-27T17:28:00.000Z",
    "sold": 1,
    "createdAt": "2022-08-27T16:28:17.000Z",
    "updatedAt": "2022-08-28T09:53:16.000Z"
  },
  "user": {
    "users_id": 3,
    "first_name": "danu",
    "last_name": "malshan",
    "profile_pic": "",
    "country": "sri lanka",
    "usdt_address": "dfxddf",
    "email": "dan.malshan@gmail.com",
    "password": "$2a$08$FYiVDcuA6a7/4Ur8OHBD8e7fLQZGE0POhCbMS9KLHgyAP7sF.Tnie",
    "ticket_count": 4,
    "last_online": "2022-09-21T15:21:04.000Z",
    "is_admin": 1,
    "chatted": 1,
    "last_msg": "Hi",
    "last_msg_time": "2022-09-13T12:31:35.000Z",
    "msg_seen": 1,
    "createdAt": "2022-08-03T16:33:12.000Z",
    "updatedAt": "2022-09-21T15:21:04.000Z"
  }
} 
*/

  int? buyerId;
  int? usersId;
  int? ticketId;
  String? paymentId;
  String? timeline;
  String? walletAddress;
  int? rank;
  int? price;
  String? createdAt;
  String? updatedAt;
  GetPreviousWinnersModelDataTicket? ticket;
  GetPreviousWinnersModelDataUser? user;

  GetPreviousWinnersModelData({
    this.buyerId,
    this.usersId,
    this.ticketId,
    this.paymentId,
    this.timeline,
    this.walletAddress,
    this.rank,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.ticket,
    this.user,
  });
  GetPreviousWinnersModelData.fromJson(Map<String, dynamic> json) {
    buyerId = json['buyer_id']?.toInt();
    usersId = json['users_id']?.toInt();
    ticketId = json['ticket_id']?.toInt();
    paymentId = json['payment_id']?.toString();
    timeline = json['timeline']?.toString();
    walletAddress = json['wallet_address']?.toString();
    rank = json['rank']?.toInt();
    price = json['price']?.toInt();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    ticket = (json['ticket'] != null) ? GetPreviousWinnersModelDataTicket.fromJson(json['ticket']) : null;
    user = (json['user'] != null) ? GetPreviousWinnersModelDataUser.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['buyer_id'] = buyerId;
    data['users_id'] = usersId;
    data['ticket_id'] = ticketId;
    data['payment_id'] = paymentId;
    data['timeline'] = timeline;
    data['wallet_address'] = walletAddress;
    data['rank'] = rank;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (ticket != null) {
      data['ticket'] = ticket!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class GetPreviousWinnersModel {
/*
{
  "data": [
    {
      "buyer_id": 16,
      "users_id": 3,
      "ticket_id": 156906,
      "payment_id": "cd755c3c-6a35-4ab0-bbc7-d3fd3ec3c1f6",
      "timeline": "EXPIRED",
      "wallet_address": "0x297ba728acdd15ef03cc174f9d71f5dac095c19a",
      "rank": 1,
      "price": 800,
      "createdAt": "2022-08-28T09:53:16.000Z",
      "updatedAt": "2022-09-20T17:30:00.000Z",
      "ticket": {
        "ticket_id": 156906,
        "ticket_type": 0,
        "round_no": 3,
        "title": "33",
        "price": 3,
        "start_date": "2022-08-27T16:28:17.000Z",
        "expire_date": "2022-08-27T17:28:00.000Z",
        "sold": 1,
        "createdAt": "2022-08-27T16:28:17.000Z",
        "updatedAt": "2022-08-28T09:53:16.000Z"
      },
      "user": {
        "users_id": 3,
        "first_name": "danu",
        "last_name": "malshan",
        "profile_pic": "",
        "country": "sri lanka",
        "usdt_address": "dfxddf",
        "email": "dan.malshan@gmail.com",
        "password": "$2a$08$FYiVDcuA6a7/4Ur8OHBD8e7fLQZGE0POhCbMS9KLHgyAP7sF.Tnie",
        "ticket_count": 4,
        "last_online": "2022-09-21T15:21:04.000Z",
        "is_admin": 1,
        "chatted": 1,
        "last_msg": "Hi",
        "last_msg_time": "2022-09-13T12:31:35.000Z",
        "msg_seen": 1,
        "createdAt": "2022-08-03T16:33:12.000Z",
        "updatedAt": "2022-09-21T15:21:04.000Z"
      }
    }
  ]
} 
*/

  List<GetPreviousWinnersModelData?>? data;

  GetPreviousWinnersModel({
    this.data,
  });
  GetPreviousWinnersModel.fromJson(Map<String, dynamic> json) {
  if (json['data'] != null) {
  final v = json['data'];
  final arr0 = <GetPreviousWinnersModelData>[];
  v.forEach((v) {
  arr0.add(GetPreviousWinnersModelData.fromJson(v));
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