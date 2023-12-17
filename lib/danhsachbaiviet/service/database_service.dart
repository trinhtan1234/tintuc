// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tintuc/danhsachbaiviet/model/todo.dart';

// // ignore: non_constant_identifier_names
// String TODO_COllECTION_REF = "danhSachBaiViet";

// class DatabaseService {
//   final _firestore = FirebaseFirestore.instance;

//   late final CollectionReference _baiVietRef;
//   DatabaseService() {
//     _baiVietRef = _firestore
//         .collection(TODO_COllECTION_REF)
//         .withConverter<BaiViet>(
//             fromFirestore: (snapshot, _) => BaiViet.fromJson(snapshot.data()!),
//             toFirestore: (baiviet, _) => baiviet.toJson());
//   }
//   Stream<QuerySnapshot> getBaiViet() {
//     return _baiVietRef.snapshots();
//   }

//   void addBaiViet(BaiViet baiViet) async {
//     _baiVietRef.add(baiViet);
//   }
// }
