import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaoBaiViet extends StatefulWidget {
  const TaoBaiViet({super.key});

  @override
  State<TaoBaiViet> createState() => _TaoBaiVietState();
}

class _TaoBaiVietState extends State<TaoBaiViet> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              child: const Text('Thêm tài liệu'),
              onPressed: () {
                final documentReference =
                    firestore.collection('baiviet').doc('NguyenVanA');

                documentReference.set({
                  'name': 'John Doe12',
                  'email': 'johndoe12@example.com',
                });
              },
            ),
            FloatingActionButton(
              child: const Text('Đọc tài liệu'),
              onPressed: () async {
                final documentReference =
                    firestore.collection('users').doc('johndoe');

                // Đọc tài liệu
                final documentSnapshot = await documentReference.get();

                // Kiểm tra xem data không phải là null trước khi truy cập
                if (documentSnapshot.data() != null) {
                  // Lấy dữ liệu từ tài liệu
                  final name = documentSnapshot.data()!['name'];
                  final email = documentSnapshot.data()!['email'];

                  // Hiển thị dữ liệu
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tên: $name, Email: $email'),
                    ),
                  );
                }
              },
            ),
            FloatingActionButton(
              child: const Text('Cập nhật tài liệu'),
              onPressed: () async {
                // Tạo tham chiếu đến tài liệu
                final documentReference =
                    firestore.collection('users').doc('johndoe');

                // Cập nhật dữ liệu trên tài liệu
                documentReference.update({
                  'name': 'Jane Doe',
                });
              },
            ),
            FloatingActionButton(
              child: const Text('Xóa tài liệu'),
              onPressed: () async {
                final documentReference =
                    firestore.collection('users').doc('johndoe');
                // Xóa tài liệu
                documentReference.delete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
