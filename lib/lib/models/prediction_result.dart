class PredictionResult {
  List<Data>? data;

  PredictionResult({this.data});

  PredictionResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  double? probablity;

  Data({this.name, this.probablity});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    probablity = json['probablity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['probablity'] = this.probablity;
    return data;
  }
}
