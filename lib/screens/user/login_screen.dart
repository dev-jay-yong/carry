import 'package:carry/model/user/kakao_login_model.dart';
import 'package:carry/services/user/kakao_login_services.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../entity/user/login_platform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;
  late Future<KakaoProfileModel> kakaoProfile;

  void signInWithKakao() async {
    try {
      kakaoProfile = KakaoSocialApiService.signInWithKakao();
      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.facebook:
        break;
      case LoginPlatform.google:
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
        break;
      case LoginPlatform.naver:
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "asset/image/new logo_S.png",
              fit: BoxFit.contain,
              height: 40,
            ),
            const IconButton(
              onPressed: null,
              icon: Icon(Icons.menu),
            )
          ],
        ),
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromRGBO(238, 238, 238, 1),
            width: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          const Text(
            "CARRY 로그인",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _loginPlatform != LoginPlatform.none
                    ? _logoutButton()
                    : _loginButton(
                        'kakao_login_large_narrow',
                        signInWithKakao,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(String path, VoidCallback onTap) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          width: 343,
          decoration: BoxDecoration(
            color: const Color(0xfffee500),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Image.asset(
            'asset/image/$path.png',
            width: 60,
            height: 60,
          ),
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return GestureDetector(
      onTap: signOut,
      child: Container(
        height: 55,
        width: 343,
        decoration: BoxDecoration(
          color: const Color(0xfffee500),
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Text(
          '로그아웃',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.lerp(FontWeight.w500, FontWeight.w600, 0.49),
          ),
        ),
      ),
    );
  }
}
