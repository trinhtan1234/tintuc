import 'package:flutter/material.dart';
import 'package:tintuc/danhsachbaiviet/tapbaiviet.dart';

class DanhSachBaiViet extends StatelessWidget {
  const DanhSachBaiViet({super.key});

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
      body: const Center(
        child: Text('Đang phát triển'),
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
