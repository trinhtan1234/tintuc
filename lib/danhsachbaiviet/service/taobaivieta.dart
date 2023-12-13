import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaoBaiVieta extends StatefulWidget {
  const TaoBaiVieta({super.key});

  @override
  State<TaoBaiVieta> createState() => _TaoBaiVietaState();
}

class _TaoBaiVietaState extends State<TaoBaiVieta> {
  final firestore = FirebaseFirestore.instance;
  final _formKeyTaoBaiVietaa = GlobalKey<FormState>();
  final TextEditingController _tieuDeController = TextEditingController();
  final TextEditingController _noiDungController = TextEditingController();
  final TextEditingController _noiDungChiTietController =
      TextEditingController();

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
                    controller: _tieuDeController,
                    decoration: const InputDecoration(labelText: 'Tiêu đề'),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  TextField(
                    controller: _noiDungController,
                    // maxLength: 999,
                    // maxLines: 17,
                    decoration: const InputDecoration(labelText: 'Nội dung '),
                  ),
                  TextField(
                    controller: _noiDungChiTietController,
                    // maxLength: 999,
                    // maxLines: 17,
                    decoration: const InputDecoration(labelText: 'Nội dung '),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   final tenTaiLieu = _tenTaiLieuController.text;
                      //   final documentReference = firestore
                      //       .collection('danhSachBaiViet')
                      //       .doc(tenTaiLieu);
                      //   documentReference.set({
                      //     'tieuDe': _tieuDeController.text,
                      //     'noiDung': _noiDungController.text,
                      //   });
                      //   // Hiển thị thông báo sau khi thêm tài liệu thành công
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Đã thêm tài liệu thành công'),
                      //     ),
                      //   );
                      //   // Quay lại màn hình trước đó
                      //   // Navigator.pop(context);
                      // }
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
