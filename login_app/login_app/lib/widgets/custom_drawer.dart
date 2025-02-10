import 'package:flutter/material.dart';
import 'package:login_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of<UserProvider>(context, listen: true);

    return Drawer(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.home,
              text: "홈",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            // _buildDrawerItem(
            //   icon: Icons.login,
            //   text: "로그인",
            //   onTap: () {
            //     Navigator.pushNamed(context, '/auth/login');
            //   },
            // ),
            // _buildDrawerItem(
            //   icon: Icons.person_add,
            //   text: "회원가입",
            //   onTap: () {
            //     Navigator.pushNamed(context, '/auth/join');
            //   },
            // ),
            _buildDrawerItem(
              icon: Icons.person,
              text: "마이",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/mypage/profile');
              },
            ),
            _buildDrawerItem(
              icon: Icons.category,
              text: "상품",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/user/product');
              },
            ),
            _buildDrawerItem(
              icon: Icons.shopping_bag,
              text: "장바구니",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/user/cart');
              },
            ),
            
          ],
        ),
        bottomSheet: 
              Container(
                // height: 100, // 원하는 높이로 설정
                color: Colors.blueAccent,
                child: 
                    userProvider != null && userProvider.isLogin ?
                    _buildDrawerItem(
                      icon: Icons.logout,
                      text: "로그아웃",
                      color: Colors.white,
                      onTap: () {
                        // 🔓 로그아웃 처리
                        userProvider.logout();
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    )
                    :
                    Row(
                      children: [
                        Expanded(child: TextButton(onPressed: (){
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/auth/login');
                        }, child: Text("로그인", style: TextStyle(color: Colors.white))),),
                        Expanded(child: TextButton(onPressed: (){
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/auth/join');
                        }, child: Text("회원가입", style: TextStyle(color: Colors.white))),),
                      ],
                    ),
                    
              )
      )
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required VoidCallback onTap, Color? color, MaterialColor? backgroundColor}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text),
      onTap: onTap,
      tileColor: backgroundColor,
      textColor: color
    );
  }
}
