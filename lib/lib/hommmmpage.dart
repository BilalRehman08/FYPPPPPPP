import 'package:flutter/material.dart';
import 'package:medi_fypp/lib/views/find_doctor_view.dart';
import 'package:medi_fypp/lib/views/prediction_view.dart';

class HomePageeee extends StatelessWidget {
  const HomePageeee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PredictionView()));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(25)),
              margin: EdgeInsets.all(15),
              height: 60,
              child: Text(
                "Predict Disease",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FindDoctorView()));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(25)),
              margin: EdgeInsets.all(15),
              height: 60,
              child: Text(
                "Find DOCTOR",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
