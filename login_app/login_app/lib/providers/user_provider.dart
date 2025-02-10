import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  // 로그인 정보
  late User _userInfo;
  // 로그인 상태
  bool _loginStat = false;

  // getter
  // get : getter 메소드를 정의하는 키워드
  User get userInfo => _userInfo;       // 전역변수
  bool get isLogin => _loginStat;       // 전역변수

  // setter
  // set : setter 메소드를 정의하는 키워드
  set userInfo(User userInfo) {
    _userInfo = userInfo;
  }
  set loginStat(bool loginStat) {
    _loginStat = loginStat;
  }

  // 🔒 안전한 저장소
  final storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  /// 🔐 로그인 요청
  /// 1. 요청 및 응답
  /// ➡ username, password 
  /// ⬅ jwt token
  /// 
  /// 2. jwt 토큰을 SecureStorage 에 저장
  Future<void> login(String username, String password) async {
    const url = 'http://10.0.2.2:8080/login';
    final requestUrl = '$url?username=$username&password=$password';
    try {
      // 로그인 요청
      final response = await _dio.get(requestUrl);
      print('================================================');

      if (response.statusCode == 200) {
        print('로그인 성공...');

        // HTTP 요청이 성공했을 때

        // JWT
        final authorizationHeader = response.headers['authorization']?.first;
        if (authorizationHeader != null) {
          // Authorization 헤더에서 "Bearer "를 제거하고 JWT 토큰 값을 추출
          final jwtToken = authorizationHeader.replaceFirst('Bearer ', '');



          // 여기서 jwtToken을 사용하면 됩니다.
          print('JWT Token: $jwtToken');

          // jwt 저장
          await storage.write(key: 'jwtToken', value: jwtToken);
          _loginStat = true;

        } else {
          // Authorization 헤더가 없는 경우 처리
          print('Authorization 헤더가 없습니다.');
        }

        // 👩‍💼 user 정보
        final userInfo = response.data;
        print('User Info: $userInfo');

        // provider 에 사용자 정보 저장
        // userInfo ➡ _userInfo 로 저장
        // provider  등록
        _userInfo = User.fromMap(userInfo);
        print(_userInfo);

      } else if( response.statusCode == 403 ) {
        print('아이디 또는 비밀번호가 일치하지 않습니다...');

      } else {
        print('네트워크 오류 또는 알 수 없는 오류로 로그인에 실패하였습니다...');

      }

    } catch (error) {
      print("로그인 처리 중 에러 발생 :  $error");
      return;
    }
    // 공유된 상태를 가진 위젯 다시 빌드
    notifyListeners();   
  }


  /// 👩‍💼👨‍💼 사용자 정보 가져오기
  /// 1. 💍 jwt ➡ 서버
  /// 2. 클라이언트 ⬅ 👩‍💼👨‍💼
  /// 3. 👩‍💼👨‍💼(userInfo) ➡ _userInfo [provider] 저장
  Future<void> getUserInfo() async {
    final url = 'http://10.0.2.2:8080/users/info';
    try {
      // 저장된 jwt 가져오기
      String? token = await storage.read(key: 'jwtToken');
      print('사용자 정보 요청 전: jwt - $token');

      final response = await _dio.get(
                                    url,
                                    options: Options(
                                      headers: {
                                        'Authorization': 'Bearer $token',
                                        'Content-Type': 'application/json',
                                      },
                                    ),
                              );

      if (response.statusCode == 200) {
        // 성공적으로 데이터를 받아왔을 때의 처리
        final userInfo = response.data;
        print('User Info: $userInfo');

        // provider 에 사용자 정보 저장
        // userInfo ➡ _userInfo 로 저장
        // provider  등록
        _userInfo = User.fromMap(userInfo);
        print(_userInfo);

      } else {
        // HTTP 요청이 실패했을 때의 처리
        print('HTTP 요청 실패: ${response.statusCode}');
        
        print('사용자 정보 요청 성공');
      } 
    }catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
    notifyListeners();
  }


  // 로그아웃
  Future<void> logout() async {
    try {

      // ⬅👨‍💼 로그아웃 처리
      // jwt 토큰 삭제
      await storage.delete(key: 'jwtToken');
      // 사용자 정보 초기화
      _userInfo = User();
      // 로그인 상태 초기화
      _loginStat = false;

      print('로그아웃 성공');
    } catch (error) {
      print('로그아웃 실패');
    }
    notifyListeners();
  }
}
