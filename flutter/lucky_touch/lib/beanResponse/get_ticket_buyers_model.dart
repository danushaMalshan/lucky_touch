///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GetTicketBuyersModelDataUser {
/*
{
  "users_id": 3,
  "first_name": "danusha",
  "last_name": "malshangg",
  "profile_pic": "https://data-starcinema.abs-cbn.com/starcinema/starcinema/media/may-2022/17/kd-estrada-is-star-magic-flex%E2%80%99s-cover-boy.jpg?ext=.jpg",
  "country": "sri lanka",
  "usdt_address": "dfxddf",
  "email": "dan.malshan@gmail.com",
  "password": "$2a$08$vhXaDz8/l05ZHCk.nNvYW.YeMaNxNK8CfHqJCkgsV/1ZvYkofptUa",
  "ticket_count": 23,
  "last_online": "2022-10-29T15:20:29.000Z",
  "is_admin": 1,
  "chatted": 0,
  "banned": 0,
  "last_msg": "sdsd",
  "last_msg_time": "2022-09-21T19:43:08.000Z",
  "msg_seen": 0,
  "createdAt": "2022-08-03T16:33:12.000Z",
  "updatedAt": "2022-10-29T16:49:11.000Z"
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
  int? banned;
  String? lastMsg;
  String? lastMsgTime;
  int? msgSeen;
  String? createdAt;
  String? updatedAt;

  GetTicketBuyersModelDataUser({
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
    this.banned,
    this.lastMsg,
    this.lastMsgTime,
    this.msgSeen,
    this.createdAt,
    this.updatedAt,
  });
  GetTicketBuyersModelDataUser.fromJson(Map<String, dynamic> json) {
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
    banned = json['banned']?.toInt();
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
    data['banned'] = banned;
    data['last_msg'] = lastMsg;
    data['last_msg_time'] = lastMsgTime;
    data['msg_seen'] = msgSeen;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class GetTicketBuyersModelDataTicket {
/*
{
  "ticket_id": 10,
  "ticket_number": "7148646924",
  "ticket_type": 0,
  "round_no": 1,
  "title": "dd",
  "price": 5,
  "start_date": "2022-10-29T16:00:23.000Z",
  "expire_date": "2022-10-29T03:30:00.000Z",
  "sold": 1,
  "createdAt": "2022-10-29T16:00:23.000Z",
  "updatedAt": "2022-10-29T16:46:39.000Z"
} 
*/

  int? ticketId;
  String? ticketNumber;
  int? ticketType;
  int? roundNo;
  String? title;
  int? price;
  String? startDate;
  String? expireDate;
  int? sold;
  String? createdAt;
  String? updatedAt;

  GetTicketBuyersModelDataTicket({
    this.ticketId,
    this.ticketNumber,
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
  GetTicketBuyersModelDataTicket.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id']?.toInt();
    ticketNumber = json['ticket_number']?.toString();
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
    data['ticket_number'] = ticketNumber;
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

class GetTicketBuyersModelData {
/*
{
  "buyer_id": 1,
  "users_id": 3,
  "ticket_id": 10,
  "payment_id": "86804b91-2b4a-48b4-98ad-30fc6a459c0d",
  "timeline": "NEW",
  "wallet_address": "0xcb5cfe1dda930fc64e41b2007bc5c9fdc6520ba5",
  "rank": 6,
  "price": 0,
  "createdAt": "2022-10-29T16:46:39.000Z",
  "updatedAt": "2022-10-29T16:57:07.000Z",
  "ticket": {
    "ticket_id": 10,
    "ticket_number": "7148646924",
    "ticket_type": 0,
    "round_no": 1,
    "title": "dd",
    "price": 5,
    "start_date": "2022-10-29T16:00:23.000Z",
    "expire_date": "2022-10-29T03:30:00.000Z",
    "sold": 1,
    "createdAt": "2022-10-29T16:00:23.000Z",
    "updatedAt": "2022-10-29T16:46:39.000Z"
  },
  "user": {
    "users_id": 3,
    "first_name": "danusha",
    "last_name": "malshangg",
    "profile_pic": "https://data-starcinema.abs-cbn.com/starcinema/starcinema/media/may-2022/17/kd-estrada-is-star-magic-flex%E2%80%99s-cover-boy.jpg?ext=.jpg",
    "country": "sri lanka",
    "usdt_address": "dfxddf",
    "email": "dan.malshan@gmail.com",
    "password": "$2a$08$vhXaDz8/l05ZHCk.nNvYW.YeMaNxNK8CfHqJCkgsV/1ZvYkofptUa",
    "ticket_count": 23,
    "last_online": "2022-10-29T15:20:29.000Z",
    "is_admin": 1,
    "chatted": 0,
    "banned": 0,
    "last_msg": "sdsd",
    "last_msg_time": "2022-09-21T19:43:08.000Z",
    "msg_seen": 0,
    "createdAt": "2022-08-03T16:33:12.000Z",
    "updatedAt": "2022-10-29T16:49:11.000Z"
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
  GetTicketBuyersModelDataTicket? ticket;
  GetTicketBuyersModelDataUser? user;

  GetTicketBuyersModelData({
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
  GetTicketBuyersModelData.fromJson(Map<String, dynamic> json) {
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
    ticket = (json['ticket'] != null) ? GetTicketBuyersModelDataTicket.fromJson(json['ticket']) : null;
    user = (json['user'] != null) ? GetTicketBuyersModelDataUser.fromJson(json['user']) : null;
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

class GetTicketBuyersModel {
/*
{
  "data": [
    {
      "buyer_id": 1,
      "users_id": 3,
      "ticket_id": 10,
      "payment_id": "86804b91-2b4a-48b4-98ad-30fc6a459c0d",
      "timeline": "NEW",
      "wallet_address": "0xcb5cfe1dda930fc64e41b2007bc5c9fdc6520ba5",
      "rank": 6,
      "price": 0,
      "createdAt": "2022-10-29T16:46:39.000Z",
      "updatedAt": "2022-10-29T16:57:07.000Z",
      "ticket": {
        "ticket_id": 10,
        "ticket_number": "7148646924",
        "ticket_type": 0,
        "round_no": 1,
        "title": "dd",
        "price": 5,
        "start_date": "2022-10-29T16:00:23.000Z",
        "expire_date": "2022-10-29T03:30:00.000Z",
        "sold": 1,
        "createdAt": "2022-10-29T16:00:23.000Z",
        "updatedAt": "2022-10-29T16:46:39.000Z"
      },
      "user": {
        "users_id": 3,
        "first_name": "danusha",
        "last_name": "malshangg",
        "profile_pic": "https://data-starcinema.abs-cbn.com/starcinema/starcinema/media/may-2022/17/kd-estrada-is-star-magic-flex%E2%80%99s-cover-boy.jpg?ext=.jpg",
        "country": "sri lanka",
        "usdt_address": "dfxddf",
        "email": "dan.malshan@gmail.com",
        "password": "$2a$08$vhXaDz8/l05ZHCk.nNvYW.YeMaNxNK8CfHqJCkgsV/1ZvYkofptUa",
        "ticket_count": 23,
        "last_online": "2022-10-29T15:20:29.000Z",
        "is_admin": 1,
        "chatted": 0,
        "banned": 0,
        "last_msg": "sdsd",
        "last_msg_time": "2022-09-21T19:43:08.000Z",
        "msg_seen": 0,
        "createdAt": "2022-08-03T16:33:12.000Z",
        "updatedAt": "2022-10-29T16:49:11.000Z"
      }
    }
  ]
} 
*/

  List<GetTicketBuyersModelData?>? data;

  GetTicketBuyersModel({
    this.data,
  });
  GetTicketBuyersModel.fromJson(Map<String, dynamic> json) {
  if (json['data'] != null) {
  final v = json['data'];
  final arr0 = <GetTicketBuyersModelData>[];
  v.forEach((v) {
  arr0.add(GetTicketBuyersModelData.fromJson(v));
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
