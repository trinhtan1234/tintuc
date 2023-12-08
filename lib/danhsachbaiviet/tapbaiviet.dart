import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaoBaiViet extends StatefulWidget {
  const TaoBaiViet({super.key});

  @override
  State<TaoBaiViet> createState() => _TaoBaiVietState();
}

class _TaoBaiVietState extends State<TaoBaiViet> {
  final _firestore = FirebaseFirestore.instance;

  String _title = '';
  String _content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Tạo mới bài viết',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Tiêu đề'),
            onChanged: (value) {
              _title = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Nội dung'),
            minLines: 5,
            maxLines: 10,
            onChanged: (value) {
              _content = value;
            },
          ),
          FloatingActionButton(
            onPressed: () {
              _firestore.collection('bai_viet').add({
                'title': _title,
                'content': _content,
                'createdAt': DateTime.now(),
              });
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }
}
