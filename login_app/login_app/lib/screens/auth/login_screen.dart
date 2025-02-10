import 'package:flutter/material.dart';
import 'package:login_app/notifications/snackbar.dart';
import 'package:login_app/providers/user_provider.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _rememberId = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        // title: Text('Login'),
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: 
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              // 아이디 입력
              TextFormField(
                controller: _usernameController,
                validator: (value) {
                  // add email validation
                  if (value == null || value.isEmpty) {
                    return '아이디를 입력해주세요.';
                  }

                  // 이메일 유효성 검사
                  // bool emailValid = RegExp(
                  //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //     .hasMatch(value);
                  // if (!emailValid) {
                  //   return 'Please enter a valid email';
                  // }

                  return null;
                },
                decoration: const InputDecoration(
                  labelText: '아이디',
                  hintText: '아이디를 입력해주세요.',
                  // prefixIcon: Icon(Icons.email_outlined),
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // 비밀번호 입력
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해주세요.';
                  }

                  if (value.length < 6) {
                    return '비밀번호는 6자 이상이어야 합니다.';
                  }
                  return null;
                },
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                    labelText: '비밀번호',
                    hintText: '비밀번호를 입력해주세요.',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: _rememberMe, onChanged: (bool? value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rememberMe = !_rememberMe;
                      });
                    },
                    child: Text('자동로그인'),
                  ),
                  Checkbox(value: _rememberId, onChanged: (bool? value) {
                    setState(() {
                      _rememberId = value!;
                    });
                  }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rememberId = !_rememberId;
                      });
                    },
                    child: Text('아이디 저장'),
                  ),
                ],
              ),
              CustomButton(text: '로그인', onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                
                final username = _usernameController.text;
                final password = _passwordController.text;

                print('로그인 시도');

                // 🔐 로그인 처리
                await userProvider.login(username, password);
                print(userProvider.isLogin);

                if( userProvider.isLogin ) {
                  print('로그인 성공');

                    Snackbar(
                    text: '로그인에 성공했습니다.',
                    icon: Icons.check_circle,
                    backgroundColor: Colors.green,
                    ).showSnackbar(context);

                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                  return;
                }

                print('로그인 실패');

                Snackbar(
                  text: '로그인에 실패했습니다. 다시 시도해주세요.',
                  icon: Icons.error,
                  backgroundColor: Colors.red,
                ).showSnackbar(context);
               
              },),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('아이디 찾기'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('비밀번호 찾기'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomButton(text: '회원가입', backgroundColor: Colors.black87 , onPressed: () {
                Navigator.pushNamed(context, '/auth/join');
              },),
            ],
          ),
        ),
      ),
    );
  }
}