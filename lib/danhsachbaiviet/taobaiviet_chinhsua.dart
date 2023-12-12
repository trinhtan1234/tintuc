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
    final formKeyTaoTin = GlobalKey<FormState>();
    final firestore = FirebaseFirestore.instance;
    final TextEditingController tieuDeController = TextEditingController();
    final TextEditingController noiDungController = TextEditingController();
    final TextEditingController noiDungChiTietController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Soạn tin bài'),
      ),
      body: Form(
        key: formKeyTaoTin,
        child: Column(
          children: [
            TextField(
              controller: tieuDeController,
              decoration: const InputDecoration(labelText: 'Tên bài viết'),
            ),
            TextField(
              controller: noiDungController,
              decoration: const InputDecoration(labelText: 'Tiêu đề'),
            ),
            Expanded(
              child: TextField(
                controller: noiDungChiTietController,
                maxLength: null,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Nội dung '),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKeyTaoTin.currentState!.validate()) {
                  // final tenTaiLieu = _tenTaiLieuController.text;
                  final documentReference =
                      firestore.collection('bai_viet').doc();
                  documentReference.set({
                    'tieuDe': tieuDeController.text,
                    'noiDung': noiDungController.text,
                    'noiDungChiTiet': noiDungChiTietController.text,
                  });
                  // Hiển thị thông báo sau khi thêm tài liệu thành công
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã thêm tài liệu thành công'),
                    ),
                  );
                  // Quay lại màn hình trước đó
                  // Navigator.pop(context);
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
