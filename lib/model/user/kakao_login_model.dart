class KakaoLoginModel {
  final String id, connected_at;

  KakaoLoginModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        connected_at = json["connected_at"];
}
