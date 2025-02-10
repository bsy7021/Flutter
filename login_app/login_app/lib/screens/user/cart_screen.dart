import 'package:flutter/material.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class CartScreen extends StatefulWidget  {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => CartScreeneScreenState();

}

class CartScreeneScreenState extends State<CartScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // 👈 Scaffold key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("장바구니"),
      ),
      // drawer: const CustomDrawer(),
      endDrawer: const CustomDrawer(),
      body: Center(
        child: const Text("장바구니 화면"),
      ),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 3,),
    );
  }

}
