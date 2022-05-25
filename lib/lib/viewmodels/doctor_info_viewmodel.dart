import 'package:maps_launcher/maps_launcher.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../models/doctors_data.dart';
import '../services/doctor_service.dart';

class DoctorInfoViewModel extends BaseViewModel {
  final doctorService = locator<DoctorService>();

  Doctor? get currentDoctor => doctorService.currentDoctor;

  int _selectedLocation = 0;
  int get selectedLocation => _selectedLocation;
  set selectedLocation(int value) {
    _selectedLocation = value;
    notifyListeners();
  }

  Future openMaps() async {
    if (currentDoctor!.locations![selectedLocation].latlong != 'xox') {
      await MapsLauncher.launchCoordinates(
        double.parse(currentDoctor!.locations![selectedLocation].latlong!
            .split(' ')[0]
            .substring(0, 10)),
        double.parse(currentDoctor!.locations![selectedLocation].latlong!
            .split(' ')[1]
            .substring(0, 10)),
        currentDoctor!.locations![selectedLocation].name,
      );
    }
  }
}
