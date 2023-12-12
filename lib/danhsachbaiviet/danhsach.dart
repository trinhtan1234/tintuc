import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tintuc/danhsachbaiviet/taobaiviet_chinhsua.dart';

class DanhSachBaiViet extends StatefulWidget {
  const DanhSachBaiViet({super.key});

  @override
  State<DanhSachBaiViet> createState() => _DanhSachBaiVietState();
}

class _DanhSachBaiVietState extends State<DanhSachBaiViet> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('bai_viet').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Đã xảy ra lỗi'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Không có bài viết nào'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final document = snapshot.data!.docs[index];
              final tieuDe = document.get('tieuDe');
              final noiDung = document.get('noiDung');
              final noiDungChiTiet = document.get('noiDungChiTiet');
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaoBaiVietCopy(
                      tieuDe: tieuDe,
                      noiDung: noiDung,
                      noiDungChiTiet: noiDungChiTiet,
                    ),
                  ),
                ),
                child: Hero(
                  tag: document.id,
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
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(noiDung),
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
        onPressed: () async {
          final route = MaterialPageRoute(
            builder: (context) => const TaoBaiVietCopy(
              tieuDe: '',
              noiDung: '',
              noiDungChiTiet: '',
            ),
          );
          Navigator.push(context, route);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
