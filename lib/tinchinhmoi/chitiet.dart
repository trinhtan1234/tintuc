// ignore: avoid_web_libraries_in_flutter

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tintuc/tinchinhmoi/tintuc.dart';

class ChiTietBaiViet extends StatefulWidget {
  const ChiTietBaiViet({
    super.key,
    this.timeTinBai,
    this.tieuDe,
    this.loaiTinBai,
    this.noiDungChiTiet,
    this.firstImageUrl,
    this.comments,
  });
  final String? tieuDe;
  final String? loaiTinBai;
  final Timestamp? timeTinBai;
  final String? noiDungChiTiet;
  final String? firstImageUrl;
  final List<String>? comments;

  @override
  State<ChiTietBaiViet> createState() => _ChiTietBaiVietState();
}

class _ChiTietBaiVietState extends State<ChiTietBaiViet> {
  late String documentId;
  @override
  void initState() {
    super.initState();
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
                    ' Nguyễn Van A',
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
                        onPressed: () {}, icon: const Icon(Icons.send)),
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
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            double screenHeight =
                                MediaQuery.of(context).size.height;
                            double containerHeight = screenHeight * 0.9;
                            return SizedBox(
                              height: containerHeight <= 0.9 * screenHeight
                                  ? containerHeight
                                  : 0.9 * screenHeight,
                              child: Scaffold(
                                appBar: AppBar(
                                  title: Text(widget.tieuDe ?? ''),
                                ),
                                body: ListView.builder(
                                  itemCount: widget.comments?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(widget.comments?[index] ?? ''),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Row(
                      children: [
                        Icon(Icons.chat_bubble_outline_outlined),
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
