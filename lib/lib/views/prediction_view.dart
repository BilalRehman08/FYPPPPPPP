import 'package:flutter/material.dart';
import 'package:medi_fypp/lib/views/prediction_result_view.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/prediction_viewmodel.dart';

class PredictionView extends StatelessWidget {
  const PredictionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PredictionViewModel>.reactive(
      viewModelBuilder: () => PredictionViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(
            child: Text(
              'Select Symptoms',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SizedBox.expand(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(
                        model.symptomNames.length,
                        (index) => GestureDetector(
                          onTap: () => model.toggleChip(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: model.selectedSymptoms[index] == 0
                                  ? Colors.white
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(width: 3, color: Colors.green),
                            ),
                            child: Text(
                              model.symptomNames[index],
                              style: TextStyle(
                                  color: model.selectedSymptoms[index] == 0
                                      ? Colors.green
                                      : Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (model.errorMessage != null)
                Text(
                  model.errorMessage.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              GestureDetector(
                onTap: () {
                  if (model.checkValidity() == true) {
                    model.predict();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PredictionResultView()));
                  }
                },
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Predict Disease',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
