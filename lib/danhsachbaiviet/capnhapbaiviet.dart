import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tintuc/danhsachbaiviet/danhsach.dart'; // Adjust this import based on your project structure

class CapNhatBaiViet extends StatefulWidget {
  final String documentId;
  final String? loaiTinBai;
  final String? tieuDe;
  final String? diaDiem;
  final String? noiDungChiTiet;
  final String? imageUrls;
  final Timestamp timeTinBai;

  const CapNhatBaiViet({
    super.key,
    required this.documentId,
    this.loaiTinBai,
    this.tieuDe,
    this.diaDiem,
    this.noiDungChiTiet,
    this.imageUrls,
    required this.timeTinBai,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CapNhatBaiVietState createState() => _CapNhatBaiVietState();
}

class _CapNhatBaiVietState extends State<CapNhatBaiViet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController tieuDeController;
  late TextEditingController diaDiemController;
  late TextEditingController noiDungChiTietController;
  late TextEditingController loaiTinBaiController;
  late TextEditingController imageUrlsController;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? pickedImage;

  List<Uint8List> pickedImagesInBytes = [];
  int imageCounts = 0;

  // ignore: unused_field
  File? _imageFile;
  // ignore: unused_field
  File? _videoFile;
  List<String> imageUrls = [];

  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://apptintuc-db349.appspot.com');

  Future<void> _pickImage() async {
    await checkAndRequestPermission();
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> checkAndRequestPermission() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      await Permission.photos.request();
    }
  }

  @override
  void initState() {
    super.initState();
    tieuDeController = TextEditingController(text: widget.tieuDe);
    diaDiemController = TextEditingController(text: widget.diaDiem);
    noiDungChiTietController =
        TextEditingController(text: widget.noiDungChiTiet);
    loaiTinBaiController = TextEditingController(text: widget.loaiTinBai);
    imageUrlsController = TextEditingController(text: widget.imageUrls);
  }

  @override
  void dispose() {
    tieuDeController.dispose();
    diaDiemController.dispose();
    noiDungChiTietController.dispose();
    loaiTinBaiController.dispose();
    imageUrlsController.dispose();
    super.dispose();
  }

  // ignore: unused_element

  Future<void> _updateBaiViet() async {
    if (!formKey.currentState!.validate()) return;
    try {
      await FirebaseFirestore.instance
          .collection('bai_viet')
          .doc(widget.documentId)
          .update({
        'tieuDe': tieuDeController.text,
        'diaDiem': diaDiemController.text,
        'noiDungChiTiet': noiDungChiTietController.text,
        'loaiTinBai': loaiTinBaiController.text,
        'imageUrls': imageUrlsController.text,
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DanhSachBaiViet()));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật bài viết thành công')));
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lỗi cập nhật bài viết: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập Nhật Bài Viết'),
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
                            Navigator.of(context).push(
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                  controller: diaDiemController,
                  decoration: const InputDecoration(labelText: 'Địa điểm'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập địa điểm';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: noiDungChiTietController,
                  decoration:
                      const InputDecoration(labelText: 'Nội dung chi tiết'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập nội dung chi tiết';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: loaiTinBaiController,
                  decoration: const InputDecoration(labelText: 'Loại tin bài'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập loại tin bài';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: imageUrlsController,
                  decoration: const InputDecoration(labelText: 'URL Hình ảnh'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập URL hình ảnh';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                if (imageUrlsController.text.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl: imageUrlsController.text,
                        // width: 150,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                imageUrlsController.text = ""; // xóa ảnh
                              });
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                          IconButton(
                            onPressed: _pickImage,
                            icon: const Text('Chọn ảnh'),
                          ),
                        ],
                      ),
                    ],
                  ),
                Container(
                  // height: 100,
                  // width: 100,
                  color: Colors.blue,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  'Thời gian bài viết: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.timeTinBai.toDate())}',
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await _updateBaiViet();
                      Navigator.pop(context);

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const DanhSachBaiViet(),
                      //   ),
                      // );
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Cập nhật tin bài',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 20)),
                        Icon(Icons.save),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Future<void> _uploadImage() async {
    if (pickedImage == null) return;

    File imageFile = File(pickedImage!.path);
    String fileName =
        'images/${DateTime.now().millisecondsSinceEpoch}_${pickedImage!.name}';
    try {
      TaskSnapshot snapshot = await _storage.ref(fileName).putFile(imageFile);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrlsController.text = downloadUrl;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lỗi khi tải ảnh lên: $e'),
      ));
    }
  }

  // ignore: unused_element
  Future<bool> _uploadFile(File? file) async {
    if (file == null) return true;

    try {
      final fileName = file.path.split('/').last;
      final ref = _storage.ref().child(fileName);

      TaskSnapshot taskSnapshot = await ref.putFile(file);

      if (taskSnapshot.state == TaskState.success) {
        String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
