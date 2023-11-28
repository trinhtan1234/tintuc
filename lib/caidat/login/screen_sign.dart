import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// late FirebaseApp app;
late FirebaseAuth auth;

class ScreenSign extends StatelessWidget {
  const ScreenSign({super.key});

  @override
  Widget build(BuildContext context) {
    auth = FirebaseAuth.instance;

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
              const Padding(padding: EdgeInsets.only(top: 80)),
              const Divider(),
              const Center(
                child: Text(
                  'Đăng nhập bằng Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),

              const Padding(padding: EdgeInsets.only(top: 20)),
              // ignore: sized_box_for_whitespace
              Container(
                width: 300,
                height: 50,
                child: TextField(
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
              // ignore: sized_box_for_whitespace
              Container(
                width: 300,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Nhập lại mật khẩu',
                    prefixIcon: const Icon(Icons.password),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                child: StreamBuilder<User?>(
                  stream: auth.authStateChanges(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return TextButton(
                        onPressed: () async {
                          // Kiểm tra định dạng email trước khi đăng nhập
                          String email =
                              "user@example.com"; // Thay đổi giá trị này thành giá trị từ TextField
// Thay đổi giá trị này thành giá trị từ TextField

                          if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                            print('Lỗi: Địa chỉ email không đúng định dạng.');
                            return;
                          }

                          try {
                            // Đăng nhập thành công
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              print('Lỗi: Địa chỉ email không đúng định dạng.');
                            } else {
                              print('Lỗi không xác định: $e');
                            }
                          }
                        },
                        child: const Center(
                          child: Center(
                            child: Text(
                              'Đăng ký',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        Flexible(
                            child: Text('Đã có user: ${snapshot.data?.email}')),
                        TextButton(
                          onPressed: () async {
                            try {
                              final userCredential =
                                  await auth.signInWithEmailAndPassword(
                                email: "",
                                password: "",
                              );
                              print(
                                  'Sign-in successful! User ID: ${userCredential.user?.uid}');
                            } catch (e) {
                              print('Error signing in: $e');
                            }
                          },
                          child: const Text('Đăng nhập'),
                        ),
                      ],
                    );
                  },
                ),

                // child: TextButton(
                //   onPressed: () {},
                //   child: const Center(
                //     child: Center(
                //         child: Text(
                //       'Đăng nhập',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 15,
                //       ),
                //     )),
                //   ),
                // ),
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
            ],
          ),
        ),
      ),
    );
  }
}
