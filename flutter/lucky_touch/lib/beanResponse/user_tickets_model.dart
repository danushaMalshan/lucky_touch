///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class UserTicketModelDataTicket {
/*
{
  "ticket_id": 11,
  "ticket_number": "8988774635",
  "ticket_type": 0,
  "round_no": 1,
  "title": "dd",
  "price": 5,
  "start_date": "2022-10-29T16:00:23.000Z",
  "expire_date": "2022-10-29T03:30:00.000Z",
  "sold": 1,
  "createdAt": "2022-10-29T16:00:23.000Z",
  "updatedAt": "2022-10-29T16:49:11.000Z"
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

  UserTicketModelDataTicket({
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
  UserTicketModelDataTicket.fromJson(Map<String, dynamic> json) {
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

class UserTicketModelData {
/*
{
  "buyer_id": 2,
  "users_id": 3,
  "ticket_id": 11,
  "payment_id": "1c8a8b47-985b-420e-900c-165303ea5dd2",
  "timeline": "NEW",
  "wallet_address": "0xe6be9cbbbf57d5684d55ed5cb6832b6926885a6a",
  "rank": null,
  "price": 0,
  "createdAt": "2022-10-29T16:49:11.000Z",
  "updatedAt": "2022-10-29T16:49:19.000Z",
  "ticket": {
    "ticket_id": 11,
    "ticket_number": "8988774635",
    "ticket_type": 0,
    "round_no": 1,
    "title": "dd",
    "price": 5,
    "start_date": "2022-10-29T16:00:23.000Z",
    "expire_date": "2022-10-29T03:30:00.000Z",
    "sold": 1,
    "createdAt": "2022-10-29T16:00:23.000Z",
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
  String? rank;
  int? price;
  String? createdAt;
  String? updatedAt;
  UserTicketModelDataTicket? ticket;

  UserTicketModelData({
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
  });
  UserTicketModelData.fromJson(Map<String, dynamic> json) {
    buyerId = json['buyer_id']?.toInt();
    usersId = json['users_id']?.toInt();
    ticketId = json['ticket_id']?.toInt();
    paymentId = json['payment_id']?.toString();
    timeline = json['timeline']?.toString();
    walletAddress = json['wallet_address']?.toString();
    rank = json['rank']?.toString();
    price = json['price']?.toInt();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    ticket = (json['ticket'] != null) ? UserTicketModelDataTicket.fromJson(json['ticket']) : null;
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
    return data;
  }
}

class UserTicketModel {
/*
{
  "data": [
    {
      "buyer_id": 2,
      "users_id": 3,
      "ticket_id": 11,
      "payment_id": "1c8a8b47-985b-420e-900c-165303ea5dd2",
      "timeline": "NEW",
      "wallet_address": "0xe6be9cbbbf57d5684d55ed5cb6832b6926885a6a",
      "rank": null,
      "price": 0,
      "createdAt": "2022-10-29T16:49:11.000Z",
      "updatedAt": "2022-10-29T16:49:19.000Z",
      "ticket": {
        "ticket_id": 11,
        "ticket_number": "8988774635",
        "ticket_type": 0,
        "round_no": 1,
        "title": "dd",
        "price": 5,
        "start_date": "2022-10-29T16:00:23.000Z",
        "expire_date": "2022-10-29T03:30:00.000Z",
        "sold": 1,
        "createdAt": "2022-10-29T16:00:23.000Z",
        "updatedAt": "2022-10-29T16:49:11.000Z"
      }
    }
  ]
} 
*/

  List<UserTicketModelData?>? data;

  UserTicketModel({
    this.data,
  });
  UserTicketModel.fromJson(Map<String, dynamic> json) {
  if (json['data'] != null) {
  final v = json['data'];
  final arr0 = <UserTicketModelData>[];
  v.forEach((v) {
  arr0.add(UserTicketModelData.fromJson(v));
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
