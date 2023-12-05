import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late FirebaseApp app;
late FirebaseAuth auth;
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController =
    TextEditingController(); // Corrected variable name
TextEditingController _nameController = TextEditingController();
TextEditingController _birthdayController = TextEditingController();
TextEditingController _genderController = TextEditingController();
TextEditingController _phoneController = TextEditingController();

class ScreenSign extends StatelessWidget {
  const ScreenSign({super.key});

  void readData() {
    print('a');
  }

  void writeData() {
    print('b');
  }

  @override
  Widget build(BuildContext context) {
    auth = FirebaseAuth.instance;

    // Khởi tạo Firebase và kết nối với cơ sở dữ liệu
    Firebase.initializeApp();
    final database = FirebaseFirestore.instance;

    // Đọc dữ liệu từ cơ sở dữ liệu
    readData();
    // Ghi dữ liệu vào cơ sở dữ liệu
    writeData();
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
                  controller: _emailController, // Added controller
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
                  controller: _passwordController, // Added controller
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
                              _emailController.text; // Use the controller value

                          if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                            ScaffoldMessenger.of(context as BuildContext)
                                .showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Địa chỉ email không đúng định dạng'),
                              ),
                            );
                            return;
                          }

                          try {
                            // Đăng nhập thành công
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              ScaffoldMessenger.of(context as BuildContext)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Địa chỉ email không đúng định dạng'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context as BuildContext)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text('Lỗi không xác định: $e'),
                                ),
                              );
                            }
                          }
                        },
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              register(context); // Pass context to register
                            },
                            child: const Text(
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
                              // print(
                              //     'Sign-in successful! User ID: ${userCredential.user?.uid}');
                            } catch (e) {
                              // print('Error signing in: $e');
                            }
                          },
                          child: const Text('Đăng nhập'),
                        ),
                      ],
                    );
                  },
                ),
              ),

              TextButton(
                onPressed: () {},
                child: Center(
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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

Future<void> register(BuildContext context) async {
  String email = _emailController.text;
  String password = _passwordController.text;

  if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(
        content: Text('Địa chỉ email không đúng định dạng'),
      ),
    );
    return;
  }

  if (password.length < 6) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(
        content: Text('Mật khẩu phải có ít nhất 6 ký tự'),
      ),
    );
    return;
  }

  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    await auth.currentUser!.sendEmailVerification();
    final user = auth.currentUser!;
    final collectionRef = FirebaseFirestore.instance.collection('users');
    final userRef = collectionRef.doc(user.uid);

    userRef.set({
      'name': _nameController.text,
      'email': email,
      'birthday': _birthdayController.text, // Adjust the value accordingly
      'gender': _genderController.text, // Adjust the value accordingly
      'phone': _phoneController.text,
    });

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(
        content: Text(
            'Đăng ký thành công. Vui lòng kiểm tra email để xác nhận tài khoản'),
      ),
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text(e.message!),
      ),
    );
  }
}
