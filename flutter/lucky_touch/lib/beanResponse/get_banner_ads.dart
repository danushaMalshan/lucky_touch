///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GetBannerAdsData {
/*
{
  "banner_id": 12,
  "banner_url": "http://luckytouch.win/images/banners/banner_34179670.jpg",
  "lunch_url": "1",
  "createdAt": "2022-10-01T06:56:48.000Z",
  "updatedAt": "2022-10-01T06:56:48.000Z"
} 
*/

  int? bannerId;
  String? bannerUrl;
  String? lunchUrl;
  String? createdAt;
  String? updatedAt;

  GetBannerAdsData({
    this.bannerId,
    this.bannerUrl,
    this.lunchUrl,
    this.createdAt,
    this.updatedAt,
  });
  GetBannerAdsData.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id']?.toInt();
    bannerUrl = json['banner_url']?.toString();
    lunchUrl = json['lunch_url']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['banner_id'] = bannerId;
    data['banner_url'] = bannerUrl;
    data['lunch_url'] = lunchUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class GetBannerAds {
/*
{
  "data": [
    {
      "banner_id": 12,
      "banner_url": "http://luckytouch.win/images/banners/banner_34179670.jpg",
      "lunch_url": "1",
      "createdAt": "2022-10-01T06:56:48.000Z",
      "updatedAt": "2022-10-01T06:56:48.000Z"
    }
  ]
} 
*/

  List<GetBannerAdsData?>? data;

  GetBannerAds({
    this.data,
  });
  GetBannerAds.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <GetBannerAdsData>[];
      v.forEach((v) {
        arr0.add(GetBannerAdsData.fromJson(v));
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