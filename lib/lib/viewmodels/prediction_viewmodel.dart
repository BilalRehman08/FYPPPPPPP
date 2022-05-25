import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../services/doctor_service.dart';

class PredictionViewModel extends BaseViewModel {
  final doctorService = locator<DoctorService>();

  List<String> symptomNames = [
    'Breathlessness',
    'Chills',
    'Vomiting',
    'Skin Rash',
    'Sweating',
    'Joint Pain',
    'High Fever',
    'Chest Pain',
    'Fatigue',
    'Headache',
    'Nausea',
    'Diarrhoea',
    'Muscle Pain',
    'Loss of appetite',
    'Pain behind the eyes',
    'Back Pain',
    'Malaise',
    'Red spots over body',
  ];
  List<int> selectedSymptoms = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  toggleChip(int index) {
    errorMessage = null;
    if (selectedSymptoms[index] == 0) {
      selectedSymptoms[index] = 1;
    } else {
      selectedSymptoms[index] = 0;
    }
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  set errorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  void predict() {
    String subUrl = selectedSymptoms.join('/');
    doctorService.predictionUrl =
        'https://mohsinraza416.pythonanywhere.com/' + subUrl;
  }

  bool checkValidity() {
    int count = 0;
    for (int i in selectedSymptoms) {
      if (i == 1) {
        count += 1;
      }
    }
    if (count < 4) {
      errorMessage = 'Please select atleast 4 Symptoms';
      return false;
    } else {
      return true;
    }
  }
}
