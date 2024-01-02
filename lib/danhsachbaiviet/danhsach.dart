import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/danhsachbaiviet/capnhapbaiviet.dart';
import 'package:tintuc/danhsachbaiviet/taobaiviet.dart';
import 'package:intl/intl.dart';
import 'package:tintuc/screen_nav_bottom.dart';

class DanhSachBaiViet extends StatefulWidget {
  const DanhSachBaiViet({super.key});

  @override
  State<DanhSachBaiViet> createState() => _DanhSachBaiVietState();
}

class _DanhSachBaiVietState extends State<DanhSachBaiViet> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MenuKhungApp(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Center(
          child: Text(
            'Danh sách bài viết',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 20,
            ),
          ),
        ),
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
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Không có bài viết nào'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final document = snapshot.data!.docs[index];
              final tieuDe = document['tieuDe'];
              final loaiTinBai = document['loaiTinBai'] ?? '';
              final diaDiem = document['diaDiem'];
              final noiDungChiTiet = document['noiDungChiTiet'] ?? '';
              final timeTinBai = document['timeTinBai'];
              final dynamic imageUrls = document['imageUrls'];
              final imageUrl =
                  imageUrls is List ? imageUrls.join(',') : imageUrls;

              final List<dynamic> imageUrlsList =
                  imageUrls is List ? imageUrls : [];

              // Lấy URL ảnh đầu tiên
              final String firstImageUrl =
                  imageUrlsList.isNotEmpty ? imageUrlsList.first : '';
              // const uniqueTag = '1';
              final uniqueTag = document.id;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CapNhatBaiViet(
                        tieuDe: tieuDe ?? '',
                        diaDiem: diaDiem ?? '',
                        noiDungChiTiet: noiDungChiTiet ?? '',
                        imageUrls: firstImageUrl,
                        timeTinBai: timeTinBai ?? '',
                        documentId: uniqueTag,
                        loaiTinBai: loaiTinBai ?? '',
                      ),
                    ),
                  );
                },
                child: SingleChildScrollView(
                  child: Hero(
                    tag: uniqueTag,
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                        bottom: 10,
                      ),
                      // padding: const EdgeInsets.all(10),
                      height: 120,
                      color: const Color.fromARGB(255, 197, 187, 187),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(loaiTinBai,
                                    overflow: TextOverflow.ellipsis),
                                Text(DateFormat('dd/MM/yyyy HH:mm')
                                    .format(timeTinBai.toDate())),
                                Text(
                                  tieuDe,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: imageUrl ?? '',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                              strokeWidth: 1,
                              strokeCap: StrokeCap.square,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaoTinBai()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
