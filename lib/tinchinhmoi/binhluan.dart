import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  final CollectionReference _commentsCollection =
      FirebaseFirestore.instance.collection('bai_viet');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bình luận'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _commentsCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var comment = snapshot.data!.docs[index];

                    var commentData = comment.data() as Map<String, dynamic>?;
                    if (commentData != null) {
                      if (commentData.containsKey('text')) {
                        return ListTile(
                          title: Text(commentData['text']),
                        );
                      } else {
                        // Kiểm tra xem "loaiTinBai" có tồn tại không
                        if (commentData.containsKey('loaiTinBai')) {
                          return ListTile(
                            title: Text(commentData['loaiTinBai'] ?? ''),
                            subtitle: Text('${commentData['userId']}'),
                            trailing: IconButton(
                              onPressed: () => _deleteComment(comment.id),
                              icon: const Icon(
                                Icons.delete,
                              ),
                            ),
                          );
                        } else {
                          // Xử lý trường hợp khi "loaiTinBai" không tồn tại
                          return const ListTile(
                            title: Text('Invalid comment data'),
                          );
                        }
                      }
                    } else {
                      // Xử lý trường hợp khi commentData là null
                      return const ListTile(
                        title: Text('Invalid comment data'),
                      );
                    }
                  },
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Bình luận',
                suffixIcon: IconButton(
                  onPressed: _submitComment,
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitComment() async {
    String commentText = _commentController.text;
    if (commentText.isNotEmpty) {
      await _commentsCollection.add({
        'text': commentText,
        'timestamp': FieldValue.serverTimestamp(),
        'userId':
            'currentUserId' // Thêm thông tin người dùng (tạm thời là user ID)
      });
      setState(() {
        _commentController.clear();
      });
    }
  }

  void _deleteComment(String commentId) async {
    await _commentsCollection.doc(commentId).delete();
  }
}
