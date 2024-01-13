import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({
    super.key,
    this.tieuDe,
    this.commnets,
  });

  final String? tieuDe;
  final List<String>? commnets;

  @override
  // ignore: library_private_types_in_public_api
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final firestore = FirebaseFirestore.instance;
  late String documentId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tieuDe ?? ''),
      ),
      body: StreamBuilder(
        stream: firestore.collection('bai_viet').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Đã xảy ra lỗi'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data?.docs;
          if (documents == null || documents.isEmpty) {
            return const Center(
              child: Text('Không có dữ liệu'),
            );
          }
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final document = documents[index];
              final List<dynamic>? comments = document['comments'];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Comments:'),
                    if (comments != null)
                      for (String comment in comments) Text(comment),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
