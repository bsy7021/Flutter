import 'package:flutter/material.dart';
import 'package:login_app/notifications/snackbar.dart';
import 'package:login_app/services/user_service.dart';
import 'package:login_app/widgets/custom_button.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {

  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _password;
  String? _confirmPassword;
  String? _name;
  String? _email;

  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
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
        child: 
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: 
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 100,
                  ),
                ),
                TextFormField(
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
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해주세요.';
                  }
                  if (value.length < 6) {
                    return '비밀번호는 6자 이상이어야 합니다.';
                  }
                  return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                  labelText: '비밀번호',
                  hintText: '비밀번호를 입력해주세요.',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호 확인을 입력해주세요.';
                  }
                  if (value != _password) {
                    return '비밀번호가 일치하지 않습니다.';
                  }
                  return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                  labelText: '비밀번호 확인',
                  hintText: '비밀번호 확인을 입력해주세요.',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                  setState(() {
                    _confirmPassword = value;
                  });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
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
                  setState(() {
                    _name = value;
                  });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
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
                  setState(() {
                    _email = value;
                  });
                  },
                ),
                SizedBox(height: 20),
                
              ],
            ),
          )
      ),
      bottomSheet: CustomButton(
        text: '회원가입',
        isFullWidth: true,
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }

          // 회원가입 로직
          bool result = await userService.registerUser(
            {
              'username': _username!,
              'password': _password!,
              'name': _name!,
              'email': _email!,
            }
          );

          if (result) {
            Snackbar(
              text: '회원가입에 성공하였습니다.',
              icon: Icons.check_circle,
              backgroundColor: Colors.green,
            ).showSnackbar(context);
            Navigator.pop(context);
          } else {
            Snackbar(
              text: '회원가입에 실패했습니다. 다시 시도해주세요.',
              icon: Icons.error,
              backgroundColor: Colors.red,
            ).showSnackbar(context);
          }

        },
      ),
    );
  }
}