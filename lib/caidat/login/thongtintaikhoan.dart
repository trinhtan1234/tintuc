import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ThongTinTaiKhoan extends StatefulWidget {
  const ThongTinTaiKhoan({super.key});

  @override
  State<ThongTinTaiKhoan> createState() => _ThongTinTaiKhoanState();
}

class _ThongTinTaiKhoanState extends State<ThongTinTaiKhoan> {
  @override
  Widget build(BuildContext context) {
    final myUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
      ),
      body: myUser == null
          ? const Center(
              child: Text('Bạn chưa đăng nhập'),
            )
          : Column(
              children: [
                Text('Email: ${myUser.email}'),
                Text('Tên tài khoản: ${myUser.displayName}'),
                Text('Số điện thoại: ${myUser.phoneNumber}'),
                TextButton(
                  onPressed: () async {
                    await myUser.updateDisplayName('TrInh vawn A');
                  },
                  child: const Text('Cập nhật tài khoản'),
                ),
              ],
            ),
    );
  }
}
