import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/danhsachbaiviet/capnhapbaiviet.dart';
import 'package:tintuc/danhsachbaiviet/taobaivieta.dart';
import 'package:tintuc/screen_nav_bottom.dart';

class DanhSachBaiViet extends StatefulWidget {
  const DanhSachBaiViet({Key? key}) : super(key: key);

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
                builder: (context) => const ScreenNavigationBottom(),
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
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = snapshot.data!.docs[index];
              final tieuDe = document['tieuDe'];
              final noiDung = document['noiDung'];
              final noiDungChiTiet = document['noiDungChiTiet'];
              final List<String> imageUrlsList =
                  List<String>.from(document['imageUrls'] ?? []);
              final String firstImageUrl =
                  imageUrlsList.isNotEmpty ? imageUrlsList.first : '';
              final uniqueTag = document.id;

              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CapNhatBaiViet(
                        tieuDe: tieuDe,
                        noiDung: noiDung,
                        noiDungChiTiet: noiDungChiTiet,
                        imageUrls: firstImageUrl,
                        documentId: uniqueTag,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: uniqueTag,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 150,
                    color: const Color.fromARGB(255, 241, 239, 239),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 100,
                          child: ListTile(
                            title: Text(
                              tieuDe,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              noiDung,
                              maxLines: 3,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.blue,
                            child: firstImageUrl.isNotEmpty
                                ? Image.network(
                                    firstImageUrl,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                      ],
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
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const TaoTinBai(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
