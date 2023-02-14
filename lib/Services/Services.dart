import 'dart:convert';
import 'dart:ffi';
import 'package:app_wedding/model/countModel.dart';
import 'package:app_wedding/model/responseEdit.dart';
import 'package:http/http.dart' as http;
import 'package:app_wedding/model/undanganModel.dart';

class Services {
  Future<undanganModel> fetchUndanganList() async {
    final response = await http
        .get(Uri.parse('https://my-wedding-serv-bxipa5vtoa-uc.a.run.app/list'));

    if (response.statusCode == 200) {
      return undanganModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Undangan');
    }
  }

  Future<countModel> fetchCount() async {
    final response = await http
        .get(Uri.parse('https://my-wedding-serv-bxipa5vtoa-uc.a.run.app/summary'));

    if (response.statusCode == 200) {
      return countModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Count');
    }
  }

  Future<responseEdit> updateMerchandise(String id) async {
    final response = await http
        .get(Uri.parse('https://my-wedding-serv-bxipa5vtoa-uc.a.run.app/edit-marchendise/${id}/1'));

    if (response.statusCode == 200) {
      return responseEdit.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Merchandise');
    }
  }

  Future<responseEdit> updateKeterangan(String id) async {
    final response = await http
        .get(Uri.parse('https://my-wedding-serv-bxipa5vtoa-uc.a.run.app/edit/${id}/Hadir'));

    if (response.statusCode == 200) {
      return responseEdit.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Keterangan');
    }
  }

  Future<undanganModel> fetchByKeterangan(int keterangan) async {
    String val= '';
    if(keterangan == 0){
      val = "Hadir";
    }else{
      val = "Tidak Hadir";
    }

    final response = await http
        .get(Uri.parse('https://my-wedding-serv-bxipa5vtoa-uc.a.run.app/list-pilihan/${val}'));

    if (response.statusCode == 200) {
      return undanganModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Merchandise');
    }
  }
}
