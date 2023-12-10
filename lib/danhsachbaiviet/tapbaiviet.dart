import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaoBaiViet extends StatefulWidget {
  const TaoBaiViet({super.key});

  @override
  State<TaoBaiViet> createState() => _TaoBaiVietState();
}

class _TaoBaiVietState extends State<TaoBaiViet> {
  final firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tieuDeController = TextEditingController();
  final TextEditingController _noiDungController = TextEditingController();
  final TextEditingController _tenTaiLieuController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Soạn tin tức'),
        ),
      ),
      body: GestureDetector(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  TextFormField(
                    controller: _tenTaiLieuController,
                    decoration: const InputDecoration(
                      labelText: 'Tên bài viết',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập thông tin';
                      }
                      return null;
                    },
                  ),

                  const Padding(padding: EdgeInsets.only(top: 10)),

                  TextFormField(
                    controller: _tieuDeController,
                    decoration: const InputDecoration(
                      labelText: 'Tên bài viết',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập thông tin';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextFormField(
                    controller: _noiDungController,
                    maxLines: null,
                    maxLength: 9999,
                    decoration: const InputDecoration(
                      labelText: 'Nội dung',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tiêu đề';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final tenTaiLieu = _tenTaiLieuController.text;
                        final documentReference = firestore
                            .collection('danhSachBaiViet')
                            .doc(tenTaiLieu);
                        documentReference.set({
                          'tieuDe': _tieuDeController.text,
                          'noiDung': _noiDungController.text,
                        });
                        // Hiển thị thông báo sau khi thêm tài liệu thành công
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã thêm tài liệu thành công'),
                          ),
                        );
                        // Quay lại màn hình trước đó
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Thêm mới tài liệu'),
                  ),
                  // TextButton(
                  //   child: const Text(
                  //     'Thêm tài liệu',
                  //   ),
                  //   onPressed: () {
                  //     final documentReference =
                  //         firestore.collection('baiviet').doc('NguyenVanA');
                  //     documentReference.set({
                  //       'name': _tieuDeController.text,
                  //       'email': _noiDungController.text,
                  //     });
                  //   },
                  // ),
                  // FloatingActionButton(
                  //   child: const Text('Thêm tài liệu'),
                  //   onPressed: () {
                  //     final documentReference =
                  //         firestore.collection('baiviet').doc('NguyenVanA');

                  //     documentReference.set({
                  //       'name': 'John Doe12',
                  //       'email': 'johndoe12@example.com',
                  //     });
                  //   },
                  // ),
                  // FloatingActionButton(
                  //   child: const Text('Đọc tài liệu'),
                  //   onPressed: () async {
                  //     final documentReference =
                  //         firestore.collection('users').doc('johndoe');

                  //     // Đọc tài liệu
                  //     final documentSnapshot = await documentReference.get();

                  //     // Kiểm tra xem data không phải là null trước khi truy cập
                  //     if (documentSnapshot.data() != null) {
                  //       // Lấy dữ liệu từ tài liệu
                  //       final name = documentSnapshot.data()!['name'];
                  //       final email = documentSnapshot.data()!['email'];

                  //       // Hiển thị dữ liệu
                  //       // ignore: use_build_context_synchronously
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           content: Text('Tên: $name, Email: $email'),
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                  // FloatingActionButton(
                  //   child: const Text('Cập nhật tài liệu'),
                  //   onPressed: () async {
                  //     // Tạo tham chiếu đến tài liệu
                  //     final documentReference =
                  //         firestore.collection('users').doc('johndoe');

                  //     // Cập nhật dữ liệu trên tài liệu
                  //     documentReference.update({
                  //       'name': 'Jane Doe',
                  //     });
                  //   },
                  // ),
                  // FloatingActionButton(
                  //   child: const Text('Xóa tài liệu'),
                  //   onPressed: () async {
                  //     final documentReference =
                  //         firestore.collection('users').doc('johndoe');
                  //     // Xóa tài liệu
                  //     documentReference.delete();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}