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
        actions: [
          IconButton(
            onPressed: () async {
              final confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Xac nhan them moi'),
                  content:
                      const Text('Ban chac chan muon them moi bai viet moi'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Huy'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Xac nhan'),
                    ),
                  ],
                ),
              );
              if (confirm) {
                formKey.currentState!.reset();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Them moi bai viet thanh cong'),
                  ),
                );
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
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
                maxLength: null,
                maxLines: null,
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
                      content: Text('Lưu thông tin bài viết thành công'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng nhập thông tin'),
                    ),
                  );
                }
              },
              child: const Text('Cập nhật tin bài'),
            ),
          ],
        ),
      ),
    );
  }
}
