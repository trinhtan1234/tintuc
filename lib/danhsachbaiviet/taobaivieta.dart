import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/danhsachbaiviet/item_list_page.dart';

class TaoBaiVieta extends StatefulWidget {
  const TaoBaiVieta({Key? key}) : super(key: key);

  @override
  State<TaoBaiVieta> createState() => _TaoBaiVietaState();
}

class _TaoBaiVietaState extends State<TaoBaiVieta> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tieuDe = TextEditingController();
  final TextEditingController noiDung = TextEditingController();
  final TextEditingController noiDungChiTiet = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();

  String selectedFile = '';
  String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';

  List<Uint8List> pickedImagesInBytes = [];
  Uint8List? selectedImageInBytes;
  int imageCounts = 0;
  List<String> imageUrls = [];
  bool isItemSaved = false;

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
          child: Text('Soạn tin tức'),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTextFormField(tieuDe, 'Tiêu đề'),
                _buildTextFormField(noiDung, 'Nội dung'),
                _buildTextFormField(noiDungChiTiet, 'Nội dung chi tiết'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _selectFile(true);
                    },
                    icon: const Icon(
                      Icons.camera,
                    ),
                    label: const Text(
                      'Pick Image',
                      style: TextStyle(),
                    ),
                  ),
                ),
                _buildImageCarousel(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _selectFile(true);
                    },
                    icon: const Icon(
                      Icons.camera,
                    ),
                    label: const Text(
                      'Pick Image',
                      style: TextStyle(),
                    ),
                  ),
                ),
                if (isItemSaved)
                  const CircularProgressIndicator(
                    color: Colors.green,
                  ),
                _buildTextField(_itemNameController, 'Item Name'),
                _buildTextField(_itemPriceController, 'Item Price'),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _saveItem();
                    }
                  },
                  child: const Text('Thêm mới tài liệu'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // Build TextFormField
  Widget _buildTextFormField(
      TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }

  // Build Image Carousel
  Widget _buildImageCarousel() {
    return Container(
      child: selectedFile.isEmpty
          ? Image.network(defaultImageUrl)
          : CarouselSlider(
              options: CarouselOptions(height: 400),
              items: pickedImagesInBytes.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Image.memory(i),
                    );
                  },
                );
              }).toList(),
            ),
    );
  }

  // Build FloatingActionButton
  Widget _buildFloatingActionButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.08,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextButton(
        onPressed: () {
          _saveItem();
        },
        child: const Text(
          'Save',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Build TextField
  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
        ),
        controller: controller,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  // Select File Method
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
    // print(selectedFile);
  }

  // Save Item Method
  Future<void> _saveItem() async {
    setState(() {
      isItemSaved = true;
    });

    // await _uploadMultipleFiles(_itemNameController.text);

    await FirebaseFirestore.instance.collection('vegetables').add({
      'itemName': _itemNameController.text,
      'itemPrice': _itemPriceController.text,
      'itemImageUrl': imageUrls,
      'createdOn': DateTime.now().toIso8601String(),
    }).then((value) {
      setState(() {
        isItemSaved = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => const ItemListPage(key: null)),
      ));
    });
  }
}
