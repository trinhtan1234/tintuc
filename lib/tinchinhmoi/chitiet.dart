// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tintuc/tinchinhmoi/tintuc.dart';

class ChiTietBaiViet extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(loaiTinBai ?? '')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                timeTinBai != null
                    ? DateFormat('EEEE, dd/MM/yyyy HH:mm')
                        .format(timeTinBai!.toDate())
                    : 'No Date',
              ),
              Text(
                tieuDe ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Container(
                child: firstImageUrl != null && firstImageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: firstImageUrl ?? '',
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
                noiDungChiTiet ?? '',
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
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              )
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
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
