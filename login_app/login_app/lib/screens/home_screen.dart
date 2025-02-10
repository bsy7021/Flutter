import 'package:flutter/material.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget  {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // 👈 Scaffold key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("홈"),
      ),
      // drawer: const CustomDrawer(),
      endDrawer: const CustomDrawer(),
      body: Center(
        child: const Text("홈 화면"),
      ),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 0,),
    );
  }

}
