// class undanganModel {
//   final String nama;
//   final int id;
//   final String keterangan;
//   final String isMerchendise;
//   final String tanggal;
//
//   const undanganModel({
//     required this.nama,
//     required this.id,
//     required this.keterangan,
//     required this.isMerchendise,
//     required this.tanggal,
//   });
//
//   factory undanganModel.fromJson(Map<String, dynamic> json) {
//     return undanganModel(
//       nama: json['nama'],
//       id: json['_id'],
//       keterangan: json['keterangan'],
//       isMerchendise: json['isMerchendise'],
//       tanggal: json['tanggal'],
//     );
//   }
// }


class undanganModel {
  String? message;
  List<Data>? data;

  undanganModel({this.message, this.data});

  undanganModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? nama;
  String? keterangan;
  String? isMerchendise;
  String? tanggal;
  int? iV;

  Data(
      {this.sId,
        this.nama,
        this.keterangan,
        this.isMerchendise,
        this.tanggal,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nama = json['nama'];
    keterangan = json['keterangan'];
    isMerchendise = json['isMerchendise'];
    tanggal = json['tanggal'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['nama'] = this.nama;
    data['keterangan'] = this.keterangan;
    data['isMerchendise'] = this.isMerchendise;
    data['tanggal'] = this.tanggal;
    data['__v'] = this.iV;
    return data;
  }
}
