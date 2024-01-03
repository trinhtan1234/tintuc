// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({
    Key? key,
    required this.tieuDe,
    this.comments,
  }) : super(key: key);
  final String? tieuDe;
  final List<String>? comments;

  @override
  // ignore: library_private_types_in_public_api
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tieuDe ?? ''),
      ),
      body: Column(
        children: [
          const Divider(),
          Row(
            children: [
              ClipOval(
                child: currentUser?.photoURL != null
                    ? Image.network(
                        currentUser?.photoURL ?? '',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.person),
              ),
              Text(widget.comments?[index] ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}
