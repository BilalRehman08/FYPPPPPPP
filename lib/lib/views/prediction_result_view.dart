import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/prediction_result_viewmodel.dart';
import 'find_doctor_view.dart';

class PredictionResultView extends StatelessWidget {
  const PredictionResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PredictionResultViewModel>.reactive(
      viewModelBuilder: () => PredictionResultViewModel(),
      onModelReady: (viewModel) => viewModel.getPrediction(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: const Center(
            child: Text(
              'Prediction Result',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: model.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : model.result == null
                ? const Center(
                    child: Text('Conection Failed'),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 7),
                      ...List.generate(
                        model.result!.data!.length,
                        (index) => GestureDetector(
                          onTap: () => model.selectedPrediction = index,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                              color: model.selectedPrediction == index
                                  ? Colors.green
                                  : Colors.white,
                              border: Border.all(
                                width: 5,
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  model.result!.data![index].name!,
                                  style: TextStyle(
                                      color: model.selectedPrediction == index
                                          ? Colors.white
                                          : Colors.green,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Probablity: ' +
                                      model.result!.data![index].probablity!
                                          .toString()
                                          .substring(0, 4) +
                                      ' %',
                                  style: TextStyle(
                                      color: model.selectedPrediction == index
                                          ? Colors.white
                                          : Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => FindDoctorView(
                                        specialization: model.getSpecByDisease(
                                            model
                                                .result!
                                                .data![model.selectedPrediction]
                                                .name!),
                                      )));
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
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
                            'Get Help',
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
    );
  }
}
