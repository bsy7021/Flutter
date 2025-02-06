import 'package:flutter/material.dart';
import 'package:user_app/screens/home_screen.dart';
import 'package:user_app/screens/join_screen.dart';
import 'package:user_app/screens/login_screen.dart';
import 'package:user_app/screens/mypage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'user app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home' : (context) => const HomeScreen(),
        '/join' : (context) => const JoinScreen(),
        '/login' : (context) => const LoginScreen(),
        '/mypage' : (context) => const MyPageScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}