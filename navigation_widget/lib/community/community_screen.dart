import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("커뮤니티"),),
      body: Center(child: Text(
        "커뮤니티 : data",
        style: TextStyle(fontSize: 30.0),
      ),)
    );
  }
}