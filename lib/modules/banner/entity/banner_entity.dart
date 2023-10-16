class BannerModel {
  int relateType;
  int mediaType;
  int sportType;
  String link;
  String title;
  String img;
  int redirectType;
  int transit;

  BannerModel({
    this.relateType = 0,
    this.mediaType = 0,
    this.sportType = 0,
    this.link = '',
    this.title = '',
    this.img = '',
    this.redirectType = 0,
    this.transit = 0,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        relateType: json['relateType'] ?? 0,
        mediaType: json['mediaType'] ?? 0,
        sportType: json['sportType'] ?? 0,
        link: json['link'] ?? '',
        title: json['title'] ?? '',
        img: json['img'] ?? '',
        redirectType: json['redirectType'] ?? 0,
        transit: json['transit'] ?? 0,
      );

  jump() {
    
  }
}
