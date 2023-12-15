import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tintuc/danhsachbaiviet/danhsach.dart';

class CapNhatBaiViet extends StatefulWidget {
  const CapNhatBaiViet({
    super.key,
    required this.documentId,
    required this.tieuDe,
    required this.noiDung,
    required this.noiDungChiTiet,
    required this.imageUrls,
    required this.timeTinBai,
  });
  final String documentId;
  final String tieuDe;
  final String noiDung;
  final String noiDungChiTiet;
  final String imageUrls;
  final Timestamp timeTinBai;

  @override
  State<CapNhatBaiViet> createState() => _CapNhatBaiVietState();
}

class _CapNhatBaiVietState extends State<CapNhatBaiViet> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tieuDeController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();
  TextEditingController noiDungChiTietController = TextEditingController();
  TextEditingController imageUrlsController = TextEditingController();

  String tieuDe = '';
  String noiDung = '';
  String noiDungChiTiet = '';
  String imageUrls = '';
  Timestamp? timeTinBai;

  @override
  void initState() {
    super.initState();

    //Khởi tạo dữ liệu từ widget
    tieuDeController.text = widget.tieuDe;
    noiDungController.text = widget.noiDung;
    noiDungChiTietController.text = widget.noiDungChiTiet;
    imageUrlsController.text = widget.imageUrls;
  }

  @override
  void dispose() {
    // tieuDeController.dispose();
    // noiDungController.dispose();
    // noiDungChiTietController.dispose();
    // hinhanhController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Soạn tin bài'),
        actions: [
          IconButton(
            onPressed: () async {
              final firestore = FirebaseFirestore.instance;
              final documentReference =
                  firestore.collection('bai_viet').doc(widget.documentId);
              // Hiển thị thông báo xác nhận xoá
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Xác nhận xoá tin bài'),
                      content:
                          const Text('Bạn chắc chắn muốn xoá tin bài này ?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            await documentReference.delete();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop(); // đóng dialog
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đã xoá tin bài thành công'),
                              ),
                            );
                            // Quay lại màn hình Danh sách bài viết
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const DanhSachBaiViet(),
                              ),
                            );
                          },
                          child: const Text('Xoá'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Huỷ'),
                        ),
                      ],
                    );
                  });
            },
            icon: const Row(
              children: [
                Text(
                  'Xoá tin bài',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: Form(
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
                decoration:
                    const InputDecoration(labelText: 'Nội dung tóm tắt'),
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
                  decoration:
                      const InputDecoration(labelText: 'Nội dung chi tiết'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập nội dung';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: imageUrlsController,
                  decoration: const InputDecoration(labelText: 'Hình ảnh'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a URL';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      imageUrls =
                          value; // Ensure imageUrl is treated as a String
                    });
                  },
                ),
              ),
              imageUrls.isNotEmpty
                  ? Image.network(
                      imageUrls,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Container(),
              Text(
                DateFormat('dd/MM/yyyy HH:mm')
                    .format(widget.timeTinBai.toDate()),
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
                      'imageUrls': imageUrlsController.text,
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
                  // Quay lại màn hình Danh sách bài viết
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const DanhSachBaiViet(),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text('Cập nhật tin bài'),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
