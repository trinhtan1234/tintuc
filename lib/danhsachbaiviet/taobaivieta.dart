import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  final TextEditingController hinhanh = TextEditingController();

  String selectedFile = '';
  List<Uint8List> pickedImagesInBytes = [];
  int imageCounts = 0;
  String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';

  List<String> imageUrls = [];

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
        child: Container(
          child: Form(
            key: _formKeyTaoBaiVietaa,
            child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 0)),
                  TextField(
                    controller: tieuDe,
                    decoration: const InputDecoration(labelText: 'Tiêu đề'),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  TextField(
                    controller: noiDung,
                    decoration: const InputDecoration(labelText: 'Nội dung '),
                  ),
                  Expanded(
                    child: TextField(
                      controller: noiDungChiTiet,
                      maxLength: 999,
                      maxLines: 15,
                      decoration: const InputDecoration(labelText: 'Nội dung '),
                    ),
                  ),
                  TextField(
                    controller: hinhanh,
                    decoration: const InputDecoration(labelText: 'Link ảnh '),
                  ),
                  const SizedBox(height: 16),
                  Expanded(child: _buildImageCarousel()),
                  Expanded(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _selectFile(true);
                          },
                          child: const Row(
                            children: [
                              Text('Thêm ảnh'),
                              Padding(padding: EdgeInsets.only(right: 5)),
                              Icon(Icons.photo_camera),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKeyTaoBaiVietaa.currentState!.validate()) {
                              await _uploadImages(); // upload images to firebase storage
                              final documentReference =
                                  firestore.collection('bai_viet').doc();
                              documentReference.set({
                                'tieuDe': tieuDe.text,
                                'noiDung': noiDung.text,
                                'noiDungChiTiet': noiDungChiTiet.text,
                                'hinhanh': hinhanh.text,
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Đã thêm tài liệu thành công'),
                                ),
                              );
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {
      selectedFile = fileResult.files.first.name;
      for (var element in fileResult.files) {
        setState(() {
          pickedImagesInBytes.add(element.bytes!);
          imageCounts += 1;
        });
      }
    }
    if (pickedImagesInBytes.isNotEmpty) {}
  }

  Widget _buildImageCarousel() {
    return Container(
      height: 100,
      child: selectedFile.isEmpty
          ? Image.network(
              defaultImageUrl,
              height: 100,
              width: 100,
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pickedImagesInBytes.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Image.memory(pickedImagesInBytes[index]),
                );
              },
            ),
    );
  }

  Future<void> _uploadImages() async {
    try {
      for (int i = 0; i < pickedImagesInBytes.length; i++) {
        Uint8List imageData = pickedImagesInBytes[i];
        String imageName = 'image_$i.jpg';

        // Upload image to firebase storage
        Reference ref =
            FirebaseStorage.instance.ref().child('images/$imageName');
        UploadTask uploadTask = ref.putData(imageData);

        // Get download link of uploaded image
        String downloadUrl = await (await uploadTask).ref.getDownloadURL();

        // Save download url to the list
        imageUrls.add(downloadUrl);
      }
    } catch (error) {
      print('Error uploading images: $error');
    }
  }
}
