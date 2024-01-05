import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tintuc/caidat/login/dangkytaikhoan.dart';
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

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveUserCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('email') && prefs.containsKey('password');
  }

//Lỗi nháy màn hình
  // @override
  // void initState() {
  //   super.initState();
  //   isUserLoggedIn().then((loggedIn) {
  //     if (loggedIn) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const ManHinhDangNhap()),
  //       );
  //     }
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng nhập',
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
                        Text('Đăng nhập với Apple'),
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
                        Text('Đăng nhập với Facebook'),
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
                        builder: (context) => const MenuKhungApp(),
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
                        Text('Đăng nhập với Google'),
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
                    prefixIcon: const Icon(Icons.mail),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
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
                          // print('Đăng nhập');
                          try {
                            final email = _userNameController.text;
                            final password = _passwordController.text;

                            await saveUserCredentials(email, password);

                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);

                            // final userCredential =
                            //     await _auth.signInWithEmailAndPassword(
                            //         email: email, password: password);
                            // print(userCredential);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ManHinhDangNhap(),
                              ),
                            );
                            // ignore: unused_catch_clause
                          } on FirebaseAuthException catch (e) {
                            // print(e.message);
                          } catch (error) {
                            // print(error);
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
                      'Quên mật khẩu',
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
                    'Bạn chưa có tài khoản ?',
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManHinhDangKy(),
                          ),
                        );
                      },
                      child: const Text('Tạo tài khoản'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
