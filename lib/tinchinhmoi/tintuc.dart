import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TinTuc extends StatefulWidget {
  const TinTuc({super.key});

  @override
  State<TinTuc> createState() => _TinTucState();
}

class _TinTucState extends State<TinTuc> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          // Lọc ra các bài viết loại "Tin tức"
          final filteredDocs = snapshot.data!.docs
              .where((doc) => doc['loaiTinBai'] == "Tin tức")
              .toList();

          if (filteredDocs.isEmpty) {
            return const Center(
              child: Text('Không có bài viết nào'),
            );
          }

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = filteredDocs[index];
              final tieuDe = document['tieuDe'];
              final diaDiem = document['diaDiem'];
              final loaiTinBai = document['loaiTinBai'];
              final noiDungChiTiet = document['noiDungChiTiet'];
              final timeTinBai = document['timeTinBai'];

              final dynamic imageUrls = document['imageUrls'];

              final List<dynamic> imageUrlsList =
                  imageUrls is List ? imageUrls : [];

              // Lấy URL ảnh đầu tiên
              final String firstImageUrl =
                  imageUrlsList.isNotEmpty ? imageUrlsList.first : '';
              // const uniqueTag = '4';
              final uniqueTag = '${document.id}-$index';

              return GestureDetector(
                onTap: () {},
                child: Hero(
                  tag: uniqueTag,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('$diaDiem : ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                    Flexible(
                                      child: Text(
                                        tieuDe,
                                        overflow: TextOverflow
                                            .clip, // Thay đổi từ ellipsis thành clip
                                        maxLines: 1, // Thay đổi từ 2 thành 1
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy HH:mm')
                                      .format(timeTinBai.toDate()),
                                ),
                                Text(
                                  noiDungChiTiet,
                                  maxLines: 3,
                                  style: const TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: firstImageUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: firstImageUrl,
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
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(loaiTinBai),
                            const Text('Bình luận'),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
