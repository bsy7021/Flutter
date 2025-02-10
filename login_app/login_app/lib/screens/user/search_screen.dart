import 'package:flutter/material.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class SearchScreen extends StatefulWidget  {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => SearchScreeneScreenState();

}

class SearchScreeneScreenState extends State<SearchScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // 👈 Scaffold key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("검색"),
      ),
      // drawer: const CustomDrawer(),
      endDrawer: const CustomDrawer(),
      body: Center(
        child: const Text("검색 화면"),
      ),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 1,),
    );
  }

}
