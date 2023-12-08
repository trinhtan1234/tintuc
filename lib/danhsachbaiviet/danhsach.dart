import 'package:flutter/material.dart';

class DanhSachBaiViet extends StatefulWidget {
  const DanhSachBaiViet({super.key});

  @override
  State<DanhSachBaiViet> createState() => _DanhSachBaiVietState();
}

class _DanhSachBaiVietState extends State<DanhSachBaiViet> {
  List<User> users = [
    User(1, 'Nguyễn Văn A', 25),
    User(2, 'Trần Thị B', 30),
    User(3, 'Lê Văn C', 22),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Danh sách bài viết'),
        ),
      ),
      body: Center(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Tên')),
            DataColumn(label: Text('Tuổi')),
            DataColumn(label: Text('Thao tác')),
          ],
          rows: users.map(
            (user) => DataRow(
              cells: [],
            ),
          ),
        ),
      ),
    );
  }
}
