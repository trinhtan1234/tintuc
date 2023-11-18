// To parse this JSON data, do
//
//     final modelNews = modelNewsFromJson(jsonString);

import 'dart:convert';

List<ModelNews> modelNewsFromJson(List news) =>
    List<ModelNews>.from(news.map((x) => ModelNews.fromJson(x)));

String modelNewsToJson(List<ModelNews> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelNews {
  int? stt;
  int? id;
  DateTime? ngaytao;
  String? tieude;
  String? noidung;
  String? noiDungChiTietDoan1;
  String? tacgia;
  String? diadiem;
  String? loaitinbai;
  String? imagetieude;
  String? imagechitiet1;
  String? imagechitiet2;
  String? imagechitiet3;
  String? video;
  String? binhluan1;
  String? binhluan2;
  String? binhluan3;
  String? binhluan4;
  String? binhluan5;

  ModelNews({
    this.stt,
    this.id,
    this.ngaytao,
    this.tieude,
    this.noidung,
    this.noiDungChiTietDoan1,
    this.tacgia,
    this.diadiem,
    this.loaitinbai,
    this.imagetieude,
    this.imagechitiet1,
    this.imagechitiet2,
    this.imagechitiet3,
    this.video,
    this.binhluan1,
    this.binhluan2,
    this.binhluan3,
    this.binhluan4,
    this.binhluan5,
  });

  factory ModelNews.fromJson(Map<String, dynamic> json) => ModelNews(
        stt: json["stt"] ?? '',
        id: json["id"] ?? '',
        ngaytao:
            json["ngaytao"] == null ? null : DateTime.parse(json["ngaytao"]),
        tieude: json["tieude"] ?? '',
        noidung: json["noidung"] ?? '',
        noiDungChiTietDoan1: json["noiDungChiTietDoan1"] ?? '',
        tacgia: json["tacgia"] ?? '',
        diadiem: json["diadiem"] ?? '',
        loaitinbai: json["loaitinbai"] ?? '',
        imagetieude: json["imagetieude"] ?? '',
        imagechitiet1: json["imagechitiet1"] ?? '',
        imagechitiet2: json["imagechitiet2"] ?? '',
        imagechitiet3: json["imagechitiet3"] ?? '',
        video: json["video"] ?? '',
        binhluan1: json["binhluan1"] ?? '',
        binhluan2: json["binhluan2"] ?? '',
        binhluan3: json["binhluan3"] ?? '',
        binhluan4: json["binhluan4"] ?? '',
        binhluan5: json["binhluan5"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "stt": stt,
        "id": id,
        "ngaytao": ngaytao?.toIso8601String(),
        "tieude": tieude,
        "noidung": noidung,
        "noiDungChiTietDoan1": noiDungChiTietDoan1,
        "tacgia": tacgia,
        "diadiem": diadiem,
        "loaitinbai": loaitinbai,
        "imagetieude": imagetieude,
        "imagechitiet1": imagechitiet1,
        "imagechitiet2": imagechitiet2,
        "imagechitiet3": imagechitiet3,
        "video": video,
        "binhluan1": binhluan1,
        "binhluan2": binhluan2,
        "binhluan3": binhluan3,
        "binhluan4": binhluan4,
        "binhluan5": binhluan5,
      };
}
