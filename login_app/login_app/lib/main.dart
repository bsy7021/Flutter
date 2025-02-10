import 'package:flutter/material.dart';
import 'package:login_app/providers/user_provider.dart';
import 'package:login_app/screens/auth/join_screen.dart';
import 'package:login_app/screens/auth/login_screen.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/mypage/profile_screen.dart';
import 'package:login_app/screens/user/cart_screen.dart';
import 'package:login_app/screens/user/product_screen.dart';
import 'package:login_app/screens/user/search_screen.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
    // ⭐ Provider
    // ChangeNotifierProvider를 사용하여 UserProvider를 전역으로 사용할 수 있도록 함
    ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: const MyApp()
    )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '로그인 앱',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // routes: {
      //   '/': (context) => HomeScreen(),
      //   '/auth/join': (context) => const JoinScreen(),
      //   '/auth/login': (context) => const LoginScreen(),
      //   '/mypage/profile': (context) => const ProfileScreen(),
      // },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // 메인
          case '/':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 회원가입
          case '/auth/join':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => JoinScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 로그인
          case '/auth/login':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 마이페이지
          case '/mypage/profile':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ProfileScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 검색
          case '/user/search':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 상품
          case '/user/product':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ProductScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 장바구니
          case '/user/cart':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => CartScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          default:
            return null;
        }
      },
    );
  }
}
