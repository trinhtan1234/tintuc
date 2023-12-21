// ignore: avoid_web_libraries_in_flutter

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tintuc/tinchinhmoi/model_comment.dart';
import 'package:tintuc/tinchinhmoi/tintuc.dart';

class ChiTietBaiViet extends StatefulWidget {
  const ChiTietBaiViet({
    super.key,
    this.timeTinBai,
    this.tieuDe,
    this.loaiTinBai,
    this.noiDungChiTiet,
    this.firstImageUrl,
  });
  final String? tieuDe;
  final String? loaiTinBai;
  final Timestamp? timeTinBai;
  final String? noiDungChiTiet;
  final String? firstImageUrl;

  @override
  State<ChiTietBaiViet> createState() => _ChiTietBaiVietState();
}

Future<void> sendComment(Comment commentData) async {
  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');
  try {
    await comments.add(commentData.toJson());
  } catch (error) {
    // ignore: avoid_print
    print('Failed to add comment: $error');
  }
}

class _ChiTietBaiVietState extends State<ChiTietBaiViet> {
  final TextEditingController _commentcontroller = TextEditingController();

  void _submitComment() {
    final String content = _commentcontroller.text;
    if (content.isNotEmpty) {
      sendComment(Comment.create(content: content));
      _commentcontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.loaiTinBai ?? '')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.timeTinBai != null
                    ? DateFormat('EEEE, dd/MM/yyyy HH:mm')
                        .format(widget.timeTinBai!.toDate())
                    : 'No Date',
              ),
              Text(
                widget.tieuDe ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Container(
                child: widget.firstImageUrl != null &&
                        widget.firstImageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.firstImageUrl ?? '',
                        width: MediaQuery.of(context).size.width - 20,
                        height: 230,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          strokeWidth: 1,
                          strokeCap: StrokeCap.square,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : const SizedBox(), // Thêm SizedBox() nếu không có hình ảnh
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Text(
                widget.noiDungChiTiet ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ' Nguyeenx Van A',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mail_outline_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.telegram_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.linked_camera_outlined,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Center(
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: _submitComment,
                        icon: const Icon(Icons.send)),
                    hintText: 'Bình luận',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TinTuc(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Aa'),
                  ),
                  IconButton(
                    onPressed: () {
                      // showModeBottomSheet(context);
                    },
                    icon: const Row(
                      children: [
                        Icon(Icons.chat_bubble_outline_outlined),
                        Text('22'),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.watch_later_outlined))
                ],
              ),
              label: ''),
        ],
      ),
    );
  }
}
