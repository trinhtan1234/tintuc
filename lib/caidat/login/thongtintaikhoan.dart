import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tintuc/caidat/login/dangnhaptaikhoan.dart';

class ThongTinTaiKhoan extends StatefulWidget {
  const ThongTinTaiKhoan({super.key});

  @override
  State<ThongTinTaiKhoan> createState() => _ThongTinTaiKhoanState();
}

class _ThongTinTaiKhoanState extends State<ThongTinTaiKhoan> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController imageUrlsController;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();

    imageUrlsController = TextEditingController();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';

      imageUrlsController.text = user.photoURL ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    imageUrlsController.dispose();
    super.dispose();
  }

  Future<void> _capNhatThongTinTaiKhoan() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updateDisplayName(_nameController.text);
          await user.updateEmail(_emailController.text);
          await user.updatePhotoURL(imageUrlsController.text);

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Thông tin tài khoản đã được cập nhật'),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: ${e.message}')),
        );
      }
    }
  }

  Future<void> _chonAnhDaiDien() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageUrlsController.text = pickedFile.path;
    }
  }

  Future<void> _dangXuat() async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ManHinhDangNhap(),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi đăng xuất: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
        actions: [
          IconButton(
            onPressed: _dangXuat,
            icon: const Row(
              children: [
                Text(
                  'Đăng xuất',
                  style: TextStyle(color: Colors.red),
                ),
                Padding(padding: EdgeInsets.only(right: 5)),
                Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Tên'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập email';
                }
                return null;
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: imageUrlsController.text.isNotEmpty
                      ? Image.network(imageUrlsController.text)
                      : const Placeholder(),
                ),
                TextButton(
                    onPressed: _chonAnhDaiDien, child: const Text('Thay ảnh'))
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton(
              onPressed: _capNhatThongTinTaiKhoan,
              child: const Text('Cập Nhật Thông Tin'),
            ),
          ],
        ),
      ),
    );
  }
}
