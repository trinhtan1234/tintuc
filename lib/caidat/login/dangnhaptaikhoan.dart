import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tintuc/caidat/login/thongtintaikhoan.dart';

import 'package:tintuc/screen_nav_bottom.dart';

class ManHinhDangNhap extends StatefulWidget {
  const ManHinhDangNhap({super.key});

  @override
  State<ManHinhDangNhap> createState() => _ManHinhDangNhapState();
}

class _ManHinhDangNhapState extends State<ManHinhDangNhap> {
  GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  final scopes = [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LOGIN',
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
              const Divider(),
              const Padding(padding: EdgeInsets.only(top: 40)),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Container(
                    // margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(
                          Icons.apple,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50),
                        ),
                        Text('Login with Apple'),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Container(
                    // margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(
                          Icons.facebook,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50),
                        ),
                        Text('Login with Facebook'),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final data = await signInWithGoogle();
                  // print(data.user.toString());
                  final user = data.user;
                  if (user != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenNavigationBottom(),
                      ),
                    );
                  } else {}
                },
                child: Center(
                  child: Container(
                    // margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Icon(
                          Icons.mail,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50),
                        ),
                        Text('Login with Google'),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              const Divider(),
              const Center(
                child: Text(
                  'Đăng nhập tài khoản',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
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
              SizedBox(
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
              const Padding(padding: EdgeInsets.only(top: 20)),
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
                          print('Dang nhap');
                          try {
                            final email = _userNameController.text;
                            final res = await _auth.signInWithEmailAndPassword(
                                email: email,
                                password: _passwordController.text);
                            print(res);
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ThongTinTaiKhoan(),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            print(e.message);
                          } catch (error) {
                            print(error);
                          }
                        },
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Container(
                    // margin: const EdgeInsets.all(20),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(color: Colors.black),
                    ),
                    child: const Center(
                        child: Text(
                      'Forgot password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do not have an account ?',
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ThongTinTaiKhoan(),
                          ),
                        );
                      },
                      child: const Text('Create acount'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
