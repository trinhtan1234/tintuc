// ignore: avoid_web_libraries_in_flutter
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// late FirebaseApp app;
late FirebaseAuth auth;
TextEditingController _emailController = TextEditingController();
TextEditingController _passordController = TextEditingController();
TextEditingController _nameController = TextEditingController();
TextEditingController _birthdayController = TextEditingController();
TextEditingController _genderController = TextEditingController();
TextEditingController _phoneController = TextEditingController();

class ScreenSign extends StatelessWidget {
  const ScreenSign({super.key});

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
                            // print('Lỗi: Địa chỉ email không đúng định dạng.');
                            return;
                          }

                          try {
                            // Đăng nhập thành công
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              // print('Lỗi: Địa chỉ email không đúng định dạng.');
                            } else {
                              // print('Lỗi không xác định: $e');
                            }
                          }
                        },
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              register();
                            },
                            child: const Text(
                              'Đăng ký',
                              style: const TextStyle(
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

// Dang ky tai khoan
Future<void> register() async {
  //Lay du lieu tu cac textfield

  String email = _emailController.text;
  String password = _passordController.text;

  if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
    // hien thi thong bao loi
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(
        content: Text('Dia chi email khong dung dinh dang'),
      ),
    );
    return;
  }
  // kiem tra do dai mat khau
  if (password.length < 6) {
    // hien thi thong bao loi
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(
        content: Text('Mat khau phai co it nhat 6 ky tu'),
      ),
    );
    return;
  }
  //tao tai khoan
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    // gui email xac nhan
    await auth.currentUser!.sendEmailVerification();
    // Luu thong tin nguoi dung vao firebase database
    final user = await auth.currentUser!;
    final collectionRef = FirebaseFirestore.instance.collection('users');
    final userRef = collectionRef.doc(user.uid);

    userRef.set({
      'name': _nameController.text,
      'email': email,
      'birthday': _birthdayController.value,
      'gender': _genderController.value,
      'phone': _phoneController.text,
    });

    // hien thi thong bao thanh cong
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(
        content: Text(
            'Dang ky thanh cong. VUi long kiem tra email de xac nhan tai khoan'),
      ),
    );
  } on FirebaseAuthException catch (e) {
    //hien thi thong bao loi
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text(e.message!),
      ),
    );
  }
}
