import 'package:stacked/stacked.dart';

import '../app/api.dart';
import '../app/locator.dart';
import '../models/prediction_result.dart';
import '../services/doctor_service.dart';

class PredictionResultViewModel extends BaseViewModel {
  final doctorService = locator<DoctorService>();

  PredictionResult? result;

  bool _isloading = true;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void getPrediction() async {
    try {
      result = await Api.getPredictionResult(doctorService.predictionUrl!);
    } catch (e) {}
    isLoading = false;
  }

  int _selectedPrediction = 0;
  int get selectedPrediction => _selectedPrediction;
  set selectedPrediction(int value) {
    _selectedPrediction = value;
    notifyListeners();
  }

  String? getSpecByDisease(String disease) {
    switch (disease) {
      case 'Dengue':
        return 'General Physician';
      case 'Heart attack':
        return 'Cardiologist';
      case 'Malaria':
        return 'General Physician';
      default:
        return null;
    }
  }
}
