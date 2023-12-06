import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class ManHinhDangKy extends StatelessWidget {
  ManHinhDangKy({super.key});

  final List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reppasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng ký tài khoản',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 100)),

              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              // ignore: sized_box_for_whitespace
              Container(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.password),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),

              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _reppasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Nhập lại mật khẩu',
                    prefixIcon: const Icon(Icons.password),
                  ),
                ),
              ),

              const Padding(padding: EdgeInsets.only(top: 10)),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Container(
                    // margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                        child: TextButton(
                      onPressed: () async {
                        print('Đăng ký');
                        try {
                          final res =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _userNameController.text,
                                  password: _passwordController.text);
                          print(res);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                          );
                        } catch (error) {
                          print(error);
                        }
                      },
                      child: const Text(
                        'Đăng ký',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
