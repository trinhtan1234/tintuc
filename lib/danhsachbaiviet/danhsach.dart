import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/danhsachbaiviet/taobaivieta.dart';
import 'package:tintuc/danhsachbaiviet/capnhapbaiviet.dart';

class DanhSachBaiViet extends StatefulWidget {
  const DanhSachBaiViet({super.key});
  @override
  State<DanhSachBaiViet> createState() => _DanhSachBaiVietState();
}

class _DanhSachBaiVietState extends State<DanhSachBaiViet> {
  final _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        key: _formKey,
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
          // Kiểm tra nếu không có dữ liệu
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Không có bài viết nào'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = snapshot.data!.docs[index];
              final tieuDe = document.get('tieuDe');
              final noiDung = document.get('noiDung');
              final noiDungChiTiet = document.get('noiDungChiTiet');
              final uniqueTag = document.id;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CapNhatBaiViet(
                        tieuDe: tieuDe,
                        noiDung: noiDung,
                        noiDungChiTiet: noiDungChiTiet,
                        documentId: uniqueTag,
                      ),
                      settings: RouteSettings(name: uniqueTag),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaoBaiVieta(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
