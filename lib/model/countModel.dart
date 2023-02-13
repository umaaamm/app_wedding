class countModel {
  String? message;
  Data? data;

  countModel({this.message, this.data});

  countModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? isMarchendiseCount;
  int? keteranganCount;
  int? totalCount;

  Data({this.isMarchendiseCount, this.keteranganCount, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    isMarchendiseCount = json['isMarchendiseCount'];
    keteranganCount = json['keteranganCount'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isMarchendiseCount'] = this.isMarchendiseCount;
    data['keteranganCount'] = this.keteranganCount;
    data['totalCount'] = this.totalCount;
    return data;
  }
}
