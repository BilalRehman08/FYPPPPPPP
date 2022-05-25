import 'package:medi_fypp/lib/app/locator.dart';
import 'package:stacked/stacked.dart';

import '../models/doctors_data.dart';
import '../services/doctor_service.dart';

class FindDoctorViewModel extends BaseViewModel {
  final doctorService = locator<DoctorService>();

  List<Doctor> get doctors => doctorService.doctors;

  bool _isloading = true;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void loadDoctors(String? spec) async {
    try {
      await doctorService.getDoctors();
      if (spec != null) {
        doctorService.filter(spec);
      }
    } catch (e) {}
    isLoading = false;
  }

  void setInfoDoctor(Doctor doc) {
    doctorService.currentDoctor = doc;
  }
}
