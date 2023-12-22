import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ThuVienHinhAnh extends StatefulWidget {
  const ThuVienHinhAnh({super.key});

  @override
  State<ThuVienHinhAnh> createState() => _ThuVienHinhAnhState();
}

class _ThuVienHinhAnhState extends State<ThuVienHinhAnh> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;
  List<Uint8List> pickedImagesInBytes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hien thi anh
          _buildImageCarousel(),
          if (_imageFile != null)
            Image.file(
              _imageFile!,
              height: 300,
              width: 300,
            ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Chọn ảnh'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    //check quyen truy cap thu vien
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

  Widget _buildImageCarousel() {
    return SizedBox(
      child: pickedImagesInBytes.isEmpty
          ? const Center(child: Text(''))
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pickedImagesInBytes.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: Image.memory(pickedImagesInBytes[index]),
                );
              },
            ),
    );
  }
}
