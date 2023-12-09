import 'package:cloud_firestore/cloud_firestore.dart';

class BaiViet {
  Timestamp ngayTao;
  String noiDungTomTat;
  String tieuDe;

  BaiViet({
    required this.ngayTao,
    required this.noiDungTomTat,
    required this.tieuDe,
  });

  BaiViet.fromJson(Map<String, Object?> json)
      : this(
          ngayTao: json['ngayTao']! as Timestamp,
          noiDungTomTat: json['noiDungTomTat']! as String,
          tieuDe: json['tieuDe']! as String,
        );

  BaiViet copyWith({
    Timestamp? ngayTao,
    String? noiDungTomTat,
    String? tieuDe,
  }) {
    return BaiViet(
      ngayTao: ngayTao ?? this.ngayTao,
      noiDungTomTat: noiDungTomTat ?? this.noiDungTomTat,
      tieuDe: tieuDe ?? this.tieuDe,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'ngayTao': Timestamp,
      'noiDungTomTat': String,
      'tieuDe': String,
    };
  }
}
