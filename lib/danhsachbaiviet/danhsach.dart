import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/danhsachbaiviet/taobaiviet.dart';

class DanhSachBaiViet extends StatefulWidget {
  const DanhSachBaiViet({super.key});
  @override
  State<DanhSachBaiViet> createState() => _DanhSachBaiVietState();
}

class _DanhSachBaiVietState extends State<DanhSachBaiViet> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Danh sách bài viết',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: firestore.collection('danhSachBaiViet').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Đã xảy ra lỗi'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Kiểm tra nếu không có dữ liệu
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Không có bài viết nào'),
            );
          }
          // Hiển thị danh sách bài viết từ snapshot
          // final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = snapshot.data!.docs[index];
              // Hiển thị thông tin từ document trong ListTile hoặc widget tương tự
              final tieuDe = document.get('tieuDe');
              final noiDung = document.get('noiDung');
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TaoBaiViet(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  color: const Color.fromARGB(255, 241, 239, 239),
                  child: ListTile(
                    title: Text(
                      tieuDe,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(noiDung),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaoBaiViet(),
            ),
          );
        },
        tooltip: 'Tạo bài viết',
        child: const Icon(Icons.add),
      ),
    );
  }
}
