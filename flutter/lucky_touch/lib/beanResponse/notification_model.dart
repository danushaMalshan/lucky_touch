///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class NotificationModelData {
/*
{
  "noti_id": 7,
  "noti_title": "Golden",
  "noti_text": "New Golden Tickets Added",
  "did_read": 0,
  "createdAt": "2022-09-09T11:42:13.000Z",
  "updatedAt": "2022-09-09T19:52:22.000Z"
} 
*/

  int? notiId;
  String? notiTitle;
  String? notiText;
  int? didRead;
  String? createdAt;
  String? updatedAt;

  NotificationModelData({
    this.notiId,
    this.notiTitle,
    this.notiText,
    this.didRead,
    this.createdAt,
    this.updatedAt,
  });
  NotificationModelData.fromJson(Map<String, dynamic> json) {
    notiId = json['noti_id']?.toInt();
    notiTitle = json['noti_title']?.toString();
    notiText = json['noti_text']?.toString();
    didRead = json['did_read']?.toInt();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['noti_id'] = notiId;
    data['noti_title'] = notiTitle;
    data['noti_text'] = notiText;
    data['did_read'] = didRead;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class NotificationModel {
/*
{
  "data": [
    {
      "noti_id": 7,
      "noti_title": "Golden",
      "noti_text": "New Golden Tickets Added",
      "did_read": 0,
      "createdAt": "2022-09-09T11:42:13.000Z",
      "updatedAt": "2022-09-09T19:52:22.000Z"
    }
  ]
} 
*/

  List<NotificationModelData?>? data;

  NotificationModel({
    this.data,
  });
  NotificationModel.fromJson(Map<String, dynamic> json) {
  if (json['data'] != null) {
  final v = json['data'];
  final arr0 = <NotificationModelData>[];
  v.forEach((v) {
  arr0.add(NotificationModelData.fromJson(v));
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
