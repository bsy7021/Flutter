
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final Dio _dio = Dio();
  final String host = 'http://10.0.2.2:8080';


  /// 회원가입
  Future<bool> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.post('$host/users', data: userData);
      if( response.statusCode == 200 || response.statusCode == 201 ) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 회원정보 조회
  Future<Map<String, dynamic>> getUser(String? username) async {
    if( username == null ) {
      return {};
    }
    try {
      final storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'jwtToken');
      final response = await _dio.get('$host/users/info',
                                        options: Options(
                                          headers: {
                                            'Authorization': 'Bearer $token',
                                            'Content-Type': 'application/json',
                                          },
                                        ),);
      if( response.statusCode == 200 ) {
        print('회원정보 조회 성공!');
        return response.data;
      } else {
        return {};
      }
    } catch (e) {
      print('getUser Error: $e');
    }
    return {};
  }
  

  /// 회원정보 수정
  Future<bool> updateUser(Map<String, dynamic> userData) async {
    try {
      final storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'jwtToken');
      final response = await _dio.put('$host/users', 
                                        data: userData,
                                        options: Options(
                                          headers: {
                                            'Authorization': 'Bearer $token',
                                            'Content-Type': 'application/json',
                                          },
                                        ),
                                      );
      if( response.statusCode == 200 || response.statusCode == 204 ) {
        print('회원정보 수정 성공!');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 회원탈퇴
  Future<bool> deleteUser(String? username) async {
    if( username == null ) {
      return false;
    }
    try {
      final storage = const FlutterSecureStorage();
      String? token = await storage.read(key: 'jwtToken');
      final response = await _dio.delete('$host/users/$username', 
                                          options: Options(
                                            headers: {
                                              'Authorization': 'Bearer $token',
                                              'Content-Type': 'application/json',
                                            },
                                          ),
                                        );
      if( response.statusCode == 200 || response.statusCode == 204 ) {
        print('회원 탈퇴 성공!');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
