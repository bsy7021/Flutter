import 'package:flutter/material.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class ProductScreen extends StatefulWidget  {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => ProductScreeneScreenState();

}

class ProductScreeneScreenState extends State<ProductScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // 👈 Scaffold key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("상품"),
      ),
      // drawer: const CustomDrawer(),
      endDrawer: const CustomDrawer(),
      body: Center(
        child: const Text("상품 화면"),
      ),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 2,),
    );
  }

}
