import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'danhsach.dart';

class TaoTinBai extends StatefulWidget {
  const TaoTinBai({Key? key}) : super(key: key);

  @override
  State<TaoTinBai> createState() => _TaoTinBaiState();
}

class _TaoTinBaiState extends State<TaoTinBai> {
  final firestore = FirebaseFirestore.instance;
  final _formKeyTaoTinBai = GlobalKey<FormState>();

  final TextEditingController tieuDe = TextEditingController();
  final TextEditingController noiDung = TextEditingController();
  final TextEditingController noiDungChiTiet = TextEditingController();

  List<Uint8List> pickedImagesInBytes = [];
  int imageCounts = 0;
  List<String> imageUrls = [];
  static const String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';

  File? _imageFile;
  File? _videoFile;
  final ImagePicker _imagePicker = ImagePicker();

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

  Future<void> _uploadFile(File? file) async {
    if (file == null) return;

    try {
      final fileName = file.path.split('/').last;
      final ref = _storage.ref().child(fileName);
      await ref.putFile(file);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File uploaded successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to upload file'),
        ),
      );
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
          child: Text('Create News'),
        ),
      ),
      body: Center(
        child: Container(
          child: Form(
            key: _formKeyTaoTinBai,
            child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 0)),
                  TextFormField(
                    controller: tieuDe,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  TextFormField(
                    controller: noiDung,
                    decoration:
                        const InputDecoration(labelText: 'Summary Content'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter summary content';
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
                          const InputDecoration(labelText: 'Detailed Content'),
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
                          : VideoPlayerController.network(''),
                    ),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Choose Image'),
                  ),
                  ElevatedButton(
                    onPressed: _pickVideo,
                    child: const Text('Choose Video'),
                  ),
                  ElevatedButton(
                    onPressed: () => _uploadFile(_imageFile),
                    child: const Text('Upload Image'),
                  ),
                  ElevatedButton(
                    onPressed: () => _uploadFile(_videoFile),
                    child: const Text('Upload Video'),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _selectFile(true);
                          },
                          child: const Row(
                            children: [
                              Text('Add Image'),
                              Padding(padding: EdgeInsets.only(right: 5)),
                              Icon(Icons.photo_camera),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKeyTaoTinBai.currentState!.validate()) {
                              await _uploadImages();
                              final documentReference =
                                  firestore.collection('bai_viet').doc();
                              documentReference.set({
                                'tieuDe': tieuDe.text,
                                'noiDung': noiDung.text,
                                'noiDungChiTiet': noiDungChiTiet.text,
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Document added successfully'),
                                ),
                              );
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const DanhSachBaiViet(),
                                ),
                              );
                            }
                          },
                          child: const Text('Add New Document'),
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
      for (var element in fileResult.files) {
        if (element.bytes != null) {
          setState(() {
            pickedImagesInBytes.add(element.bytes!);
            imageCounts += 1;
          });
        }
      }
    }
  }

  Widget _buildImageCarousel() {
    return SizedBox(
      height: 100,
      child: pickedImagesInBytes.isEmpty
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
