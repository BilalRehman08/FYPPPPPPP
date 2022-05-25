import 'dart:convert';

import '../models/doctors_data.dart';
import 'package:http/http.dart' as http;

import '../models/prediction_result.dart';

class Api {
  static Future<DoctorData> getDoctorData() async {
    var url = Uri.parse('http://mohsinraza415.pythonanywhere.com/');
    try {
      http.Response responce =
          await http.get(url, headers: {"Access-Control-Allow-Origin": "*"});
      Map<String, dynamic> json = jsonDecode(responce.body);
      DoctorData doctorData = DoctorData.fromJson(json);
      return doctorData;
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future<PredictionResult> getPredictionResult(String urll) async {
    var url = Uri.parse(urll);
    try {
      http.Response responce = await http.get(url);
      Map<String, dynamic> json = jsonDecode(responce.body);
      PredictionResult result = PredictionResult.fromJson(json);
      return result;
    } catch (e) {
      throw (e.toString());
    }
  }
}
