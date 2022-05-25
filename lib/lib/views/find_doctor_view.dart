import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/find_doctor_viewmodel.dart';
import 'doctor_info_view.dart';

class FindDoctorView extends StatelessWidget {
  String? specialization;

  FindDoctorView({Key? key, this.specialization}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FindDoctorViewModel>.reactive(
      viewModelBuilder: () => FindDoctorViewModel(),
      onModelReady: (viewModel) => viewModel.loadDoctors(specialization),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(
            child: Text(
              'Find Doctor',
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
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      model.doctors.length,
                      (index) => GestureDetector(
                        onTap: () {
                          model.setInfoDoctor(model.doctors[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const DoctorInfoView()));
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 100,
                          margin: const EdgeInsets.only(
                              top: 15, left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.doctors[index].name!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Text(
                                  model.doctors[index].specialization!
                                      .join(', '),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Experience: ' +
                                      model.doctors[index].experience!
                                          .toString() +
                                      ' yr(s)',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
      ),
    );
  }
}
