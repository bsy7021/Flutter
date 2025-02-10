import 'package:flutter/material.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/notifications/snackbar.dart';
import 'package:login_app/providers/user_provider.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/services/user_service.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:login_app/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // 👈 Scaffold key

  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  
  User? _user;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {

    // listen: (provider 구독여부)
    // - true : provider 에서 notifyListeners() 호출 시, consumer 리렌더링 ⭕
    // - false : provider 에서 notifyListeners() 호출 시, consumer 리렌더링 ❌
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: true);

    
    // 로그인 상태 확인
    if (!userProvider.isLogin) {
      // 로그인 페이지로 리디렉션
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 쌓여있는 화면 있으면 제거
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushNamed(context, "/auth/login");
      });
      return const HomeScreen();
    }

    String? _username = userProvider.userInfo.username ?? '없음';
    String? _name = userProvider.userInfo.name ?? '없음';
    String? _email = userProvider.userInfo.email ?? '없음';

    _usernameController.text = _user?.username ?? _username;
    _nameController.text = _user?.name ?? _name;
    _emailController.text = _user?.email ?? _email;

    if( _user == null ) {
      userService.getUser(_username).then((value) {
        setState(() {
          _user = User.fromMap(value);
        });
      });

    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: 
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text("프로필 수정", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '아이디를 입력해주세요.';
                  }
                  return null;
                  },
                  decoration: const InputDecoration(
                  labelText: '아이디',
                  hintText: '아이디를 입력해주세요.',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력해주세요.';
                  }
                  return null;
                  },
                  decoration: const InputDecoration(
                  labelText: '이름',
                  hintText: '이름을 입력해주세요.',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _name = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이메일을 입력해주세요.';
                  }
                  bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                  if (!emailValid) {
                    return '유효한 이메일을 입력해주세요.';
                  }
                  return null;
                  },
                  decoration: const InputDecoration(
                  labelText: '이메일',
                  hintText: '이메일을 입력해주세요.',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: '회원 탈퇴',
                  color: Colors.white,
                  isFullWidth: true,
                  backgroundColor: Colors.redAccent,
                  onPressed: () {

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('회원 탈퇴'),
                          content: Text('정말로 탈퇴하시겠습니까?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('취소'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                // 회원 탈퇴
                                userService.deleteUser(_username).then((value) {
                                  if (value) {
                                    // 회원 탈퇴 성공
                                    // 로그아웃 처리
                                    userProvider.loginStat = false;
                                    // 홈 화면으로 이동
                                    Navigator.pushNamed(context, '/');
                                  }
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );

                    
                  },
                ),
                
              ],
            ),
          )
      ),
      bottomSheet: CustomButton(
        text: '회원 정보 수정',
        isFullWidth: true,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // 👩‍🔧 회원 정보 수정 처리
            bool result = await userService.updateUser(
              {
                'username': _username,
                'name': _name,
                'email': _email,
              }
            );
            if( result ) {
              Snackbar(
                text: '회원정보 수정에 성공하였습니다.',
                icon: Icons.check_circle,
                backgroundColor: Colors.green,
              ).showSnackbar(context);
              // 수정된 정보로 업데이트 - provider
              userProvider.userInfo = User(
                username: _username,
                name: _name,
                email: _email,
              );
              
            }
          }
        },
      ),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 4,),
    );
  }
}