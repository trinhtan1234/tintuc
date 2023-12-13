import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/danhsachbaiviet/danhsach.dart';

class TaoBaiVieta extends StatefulWidget {
  const TaoBaiVieta({super.key});

  @override
  State<TaoBaiVieta> createState() => _TaoBaiVietaState();
}

class _TaoBaiVietaState extends State<TaoBaiVieta> {
  final firestore = FirebaseFirestore.instance;
  final _formKeyTaoBaiVietaa = GlobalKey<FormState>();
  final TextEditingController tieuDe = TextEditingController();
  final TextEditingController noiDung = TextEditingController();
  final TextEditingController noiDungChiTiet = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Soạn tin tức'),
        ),
      ),
      body: Center(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Form(
            key: _formKeyTaoBaiVietaa,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  TextField(
                    controller: tieuDe,
                    decoration: const InputDecoration(labelText: 'Tiêu đề'),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextField(
                    controller: noiDung,
                    // maxLength: 999,
                    // maxLines: 17,
                    decoration: const InputDecoration(labelText: 'Nội dung '),
                  ),
                  Expanded(
                    child: TextField(
                      controller: noiDungChiTiet,
                      maxLength: 999,
                      // maxLines: 15,
                      decoration: const InputDecoration(labelText: 'Nội dung '),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKeyTaoBaiVietaa.currentState!.validate()) {
                        // final tenTaiLieu = _tenTaiLieuController.text;
                        final documentReference =
                            firestore.collection('bai_viet').doc();
                        documentReference.set({
                          'tieuDe': tieuDe.text,
                          'noiDung': noiDung.text,
                          'noiDungChiTiet': noiDungChiTiet.text,
                        });

                        // Hiển thị thông báo sau khi thêm tài liệu thành công
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã thêm tài liệu thành công'),
                          ),
                        );
                        // Quay lại màn hình Danh sách bài viết
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const DanhSachBaiViet(),
                          ),
                        );
                      }
                    },
                    child: const Text('Thêm mới tài liệu'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
