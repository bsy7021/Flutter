import 'package:flutter/material.dart';
import 'package:user_app/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("메인 화면"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant,
            size: 200.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/join');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "회원가입",
                  style: TextStyle(fontSize: 21),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "로그인",
                  style: TextStyle(fontSize: 21),
                ),
              ),
            ],
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () {
            showModalBottomSheet(context: context, builder: (context) {
              return _bottomSheetContent(context);
            },);
          }
        ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "메인",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "검색",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "상품",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "장바구니",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "마이",
          ),
        ],
      ),
    );
  }
}


Widget _bottomSheetContent (BuildContext test) {
  return Column(children: [
    ListTile(
      leading: Icon(Icons.accessibility_new_sharp),
      title: Text("커요미"),
      subtitle: Text("귀여워"),
    )
  ],);
}