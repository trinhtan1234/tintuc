import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'danhsach.dart';

class TaoTinBai extends StatefulWidget {
  const TaoTinBai({super.key});

  @override
  State<TaoTinBai> createState() => _TaoTinBaiState();
}

class _TaoTinBaiState extends State<TaoTinBai> {
  final firestore = FirebaseFirestore.instance;
  final _formKeyTaoTinBai = GlobalKey<FormState>();

  final TextEditingController tieuDe = TextEditingController();
  final TextEditingController noiDung = TextEditingController();
  final TextEditingController noiDungChiTiet = TextEditingController();
  Timestamp timeTinBai = Timestamp.now();

  List<Uint8List> pickedImagesInBytes = [];
  int imageCounts = 0;

  File? _imageFile;
  File? _videoFile;
  final ImagePicker _imagePicker = ImagePicker();
  List<String> imageUrls = [];

  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://tintuc-a0ba2.appspot.com');

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile =
        await _imagePicker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  Future<bool> _uploadFile(File? file) async {
    if (file == null) return false;

    try {
      final fileName = file.path.split('/').last;
      final ref = _storage.ref().child(fileName);
      await ref.putFile(file).then((p) async {
        String downloadUrl = await p.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    tieuDe.dispose();
    noiDung.dispose();
    noiDungChiTiet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Soạn tin bài'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: Form(
          key: _formKeyTaoTinBai,
          child: Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(),
                const Padding(padding: EdgeInsets.only(top: 0)),
                TextFormField(
                  controller: tieuDe,
                  decoration: const InputDecoration(labelText: 'Tiêu đề'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Nhập thông tin tiêu đề';
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                TextFormField(
                  controller: noiDung,
                  decoration:
                      const InputDecoration(labelText: 'Tóm tắt nội dung'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Nhập tóm tắt nội dung';
                    }
                    return null;
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: noiDungChiTiet,
                    maxLength: 999,
                    maxLines: 15,
                    decoration:
                        const InputDecoration(labelText: 'Nội dung chi tiết'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Nhập tóm tắt nội dung';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildImageCarousel()),
                if (_imageFile != null)
                  Image.file(
                    _imageFile!,
                    height: 150,
                  ),
                if (_videoFile != null)
                  VideoPlayer(
                    _videoFile != null
                        ? VideoPlayerController.file(_videoFile!)
                        : VideoPlayerController.networkUrl('' as Uri),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Chọn ảnh'),
                    ),
                    ElevatedButton(
                      onPressed: _pickVideo,
                      child: const Text('Chọn video'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKeyTaoTinBai.currentState!.validate()) {
                      bool imageUploadSuccess = await _uploadFile(_imageFile);
                      if (!mounted) return;

                      if (imageUploadSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('File upload thành công')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Lỗi tải file')),
                        );
                      }

                      await _uploadFile(_videoFile);
                      if (!mounted) return;

                      await _uploadImages();
                      if (!mounted) return;

                      final documentReference =
                          firestore.collection('bai_viet').doc();
                      await documentReference.set({
                        'tieuDe': tieuDe.text,
                        'noiDung': noiDung.text,
                        'noiDungChiTiet': noiDungChiTiet.text,
                        'imageUrls': imageUrls,
                        'timeTinBai': timeTinBai,
                      });
                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Thêm tin bài thành công')),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const DanhSachBaiViet()),
                      );
                    }
                  },
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: const BoxDecoration(border: Border()),
                    child: const Center(
                      child: Text('Thêm tin bài'),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return SizedBox(
      height: 100,
      child: pickedImagesInBytes.isEmpty
          ? const Center(child: Text('No images selected'))
          : ListView.builder(
              scrollDirection:
                  Axis.horizontal, // Đúng vị trí cho scrollDirection
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
      // ignore: avoid_print
      print('Error uploading images: $error');
    }
  }
}
