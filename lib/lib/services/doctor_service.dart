import 'package:injectable/injectable.dart';

import '../app/api.dart';
import '../models/doctors_data.dart';

@lazySingleton
class DoctorService {
  List<Doctor> doctors = <Doctor>[];
  List<String> specs = <String>[];

  Future getDoctors() async {
    try {
      DoctorData doctorsData = await Api.getDoctorData();
      doctors = doctorsData.doctors!;
      specs = doctorsData.specs!;
    } catch (e) {
      throw (e.toString());
    }
  }

  Doctor? currentDoctor;

  String? predictionUrl;

  void filter(String? spec) {
    if (doctors.isNotEmpty) {
      List<Doctor> newDoctors = <Doctor>[];
      doctors.forEach((element) {
        if (element.specialization!.contains(spec)) {
          newDoctors.add(element);
        }
      });
      doctors = newDoctors;
    }
  }
}
