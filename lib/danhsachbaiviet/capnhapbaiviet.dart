import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CapNhatBaiViet extends StatefulWidget {
  const CapNhatBaiViet(
      {super.key,
      required this.documentId,
      required this.tieuDe,
      required this.noiDung,
      required this.noiDungChiTiet});
  final String documentId;
  final String tieuDe;
  final String noiDung;
  final String noiDungChiTiet;

  @override
  State<CapNhatBaiViet> createState() => _CapNhatBaiVietState();
}

class _CapNhatBaiVietState extends State<CapNhatBaiViet> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tieuDeController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();
  TextEditingController noiDungChiTietController = TextEditingController();

  String tieuDe = '';
  String noiDung = '';
  String noiDungChiTiet = '';

  @override
  void initState() {
    super.initState();

    //Khởi tạo dữ liệu từ widget
    tieuDeController.text = widget.tieuDe;
    noiDungController.text = widget.noiDung;
    noiDungChiTietController.text = widget.noiDungChiTiet;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Soạn tin bài'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: tieuDeController,
              decoration: const InputDecoration(labelText: 'Tên bài viết'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên bài viết';
                }
                return null;
              },
            ),
            TextFormField(
              controller: noiDungController,
              decoration: const InputDecoration(labelText: 'Tiêu đề'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tiêu đề';
                }
                return null;
              },
            ),
            Expanded(
              child: TextFormField(
                controller: noiDungChiTietController,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Nội dung'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập nội dung';
                  }
                  return null;
                },
              ),
            ),
            TextButton(
              // key: formKeyCapNhat,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  //Tạo tham chiếu đến document
                  final documentRef = FirebaseFirestore.instance
                      .collection('bai_viet')
                      .doc(widget.documentId);
                  // Cập nhật dữ liệu
                  documentRef.update({
                    // documentId: uniqueTag,
                    'tieuDe': tieuDeController.text,
                    'noiDung': noiDungController.text,
                    'noiDungChiTiet': noiDungChiTietController.text,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cập nhật thông tin bài viết thành công'),
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
