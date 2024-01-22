class KakaoProfileModel {
  final String connected_at;
  final int id;

  KakaoProfileModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        connected_at = json["connected_at"];
}
