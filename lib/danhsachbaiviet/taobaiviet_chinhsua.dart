import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaoBaiVietCopy extends StatelessWidget {
  const TaoBaiVietCopy(
      {super.key,
      required this.tieuDe,
      required this.noiDung,
      required this.noiDungChiTiet});
  final String tieuDe;
  final String noiDung;
  final String noiDungChiTiet;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Soạn tin bài'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: tieuDe),
              decoration: const InputDecoration(labelText: 'Tên bài viết'),
            ),
            TextField(
              controller: TextEditingController(text: noiDung),
              decoration: const InputDecoration(labelText: 'Tiêu đề'),
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: noiDungChiTiet),
                maxLength: 999,
                maxLines: 17,
                decoration: const InputDecoration(labelText: 'Nội dung '),
              ),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  //Luu vao firestore
                  firestore.collection('bai_viet').add({
                    'tieuDe': tieuDe,
                    'noiDung': noiDung,
                    'noiDungChiTiet': noiDungChiTiet,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Luu bai viet thanh cong'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui long nhap day du thong tin'),
                    ),
                  );
                }
              },
              child: const Text('Thêm mới tài liệu'),
            ),
          ],
        ),
      ),
    );
  }
}
