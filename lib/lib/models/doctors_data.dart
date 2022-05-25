class DoctorData {
  List<Doctor>? doctors;
  List<String>? specs;

  DoctorData({this.doctors, this.specs});

  DoctorData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      doctors = <Doctor>[];
      json['data'].forEach((v) {
        doctors!.add(new Doctor.fromJson(v));
      });
    }
    specs = json['specs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctors != null) {
      data['data'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    data['specs'] = this.specs;
    return data;
  }
}

class Doctor {
  String? description;
  int? experience;
  String? id;
  List<Locations>? locations;
  String? name;
  List<String>? specialization;

  Doctor(
      {this.description,
      this.experience,
      this.id,
      this.locations,
      this.name,
      this.specialization});

  Doctor.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    experience = json['experience'];
    id = json['id'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
    name = json['name'];
    specialization = json['specialization'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['experience'] = this.experience;
    data['id'] = this.id;
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['specialization'] = this.specialization;
    return data;
  }
}

class Locations {
  List<String>? days;
  String? latlong;
  String? name;
  Timing? timing;

  Locations({this.days, this.latlong, this.name, this.timing});

  Locations.fromJson(Map<String, dynamic> json) {
    days = json['days'].cast<String>();
    latlong = json['latlong'];
    name = json['name'];
    timing =
        json['timing'] != null ? new Timing.fromJson(json['timing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this.days;
    data['latlong'] = this.latlong;
    data['name'] = this.name;
    if (this.timing != null) {
      data['timing'] = this.timing!.toJson();
    }
    return data;
  }
}

class Timing {
  String? from;
  String? to;

  Timing({this.from, this.to});

  Timing.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
