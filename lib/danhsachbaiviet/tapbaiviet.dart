import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaoBaiViet extends StatefulWidget {
  const TaoBaiViet({Key? key}) : super(key: key);

  @override
  State<TaoBaiViet> createState() => _TaoBaiVietState();
}

class _TaoBaiVietState extends State<TaoBaiViet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  // late String _imagePath;

  final FocusNode _textFocusNode = FocusNode();

  void _dangBai() async {
    try {
      if (_formKey.currentState!.validate()) {
        String title = _titleController.text;
        String summary = _summaryController.text;
        String content = _contentController.text;

        await FirebaseFirestore.instance.collection('tintuc').add({
          'title': title,
          'summary': summary,
          'content': content,
        });
        _formKey.currentState!.reset();

        setState(() {});
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã gửi thành công!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error submitting data: $error');
    }
  }

  // Future<void> _pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       // _imagePath = pickedFile.path;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biểu Mẫu Bài Viết'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                focusNode: _textFocusNode,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Tiêu Đề'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập tiêu đề cho bài viết';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _summaryController,
                decoration: const InputDecoration(labelText: 'Tóm Tắt'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập tóm tắt cho bài viết';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Nội Dung'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập nội dung cho bài viết';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Chọn Ảnh'),
              ),

              // _imagePath != null ? Image.network(_imagePath) : Container(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _dangBai,
                child: const Text('Gửi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
