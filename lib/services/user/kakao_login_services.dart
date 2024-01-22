import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import '../../model/user/kakao_login_model.dart';

class KakaoSocialApiService {
  static const String baseUrl = 'https://kapi.kakao.com';

  static Future<KakaoProfileModel> signInWithKakao() async {
    bool isInstalled = await isKakaoTalkInstalled();

    OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();

    final url = Uri.parse('$baseUrl/v2/user/me');

    final response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'},
    );

    if (response.statusCode == 200) {
      final kakaoProfileInfo = jsonDecode(response.body);
      return KakaoProfileModel.fromJson(kakaoProfileInfo);
    }
    throw Error();
  }
}
