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
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Không có bài viết nào'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = snapshot.data!.docs[index];
              final tieuDe = document['tieuDe'];
              final noiDung = document['noiDung'];
              // final noiDungChiTiet = document['noiDungChiTiet'];
              final timeTinBai = document['timeTinBai'];

              final dynamic imageUrls = document['imageUrls'];

              final List<dynamic> imageUrlsList =
                  imageUrls is List ? imageUrls : [];

              // Lấy URL ảnh đầu tiên
              final String firstImageUrl =
                  imageUrlsList.isNotEmpty ? imageUrlsList.first : '';

              final uniqueTag = document.id;
              return GestureDetector(
                onTap: () {},
                child: Hero(
                  tag: uniqueTag,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 400,
                    // color: const Color.fromARGB(255, 241, 239, 239),
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            // width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tieuDe,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy HH:mm')
                                      .format(timeTinBai.toDate()),
                                ),
                                Text(
                                  noiDung,
                                  maxLines: 3,
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
