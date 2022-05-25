import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/doctor_info_viewmodel.dart';

class DoctorInfoView extends StatelessWidget {
  const DoctorInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoctorInfoViewModel>.reactive(
      viewModelBuilder: () => DoctorInfoViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              height: 170,
              color: Colors.green,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: Colors.white),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.currentDoctor!.name!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              model.currentDoctor!.specialization!.join(', '),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Available Locations:',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...List.generate(
                        model.currentDoctor!.locations!.length,
                        (index) => GestureDetector(
                          onTap: () => model.selectedLocation = index,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            margin: const EdgeInsets.only(top: 15),
                            height: 80,
                            decoration: BoxDecoration(
                              color: model.selectedLocation == index
                                  ? Colors.green
                                  : Colors.white,
                              border: Border.all(width: 5, color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.currentDoctor!.locations![index].name!,
                                  style: TextStyle(
                                    color: model.selectedLocation == index
                                        ? Colors.white
                                        : Colors.green,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  model.currentDoctor!.locations![index].timing!
                                          .to! +
                                      ' - ' +
                                      model.currentDoctor!.locations![index]
                                          .timing!.from! +
                                      '  (' +
                                      model.currentDoctor!.locations![index]
                                          .days!
                                          .join(', ') +
                                      ')',
                                  style: TextStyle(
                                    color: model.selectedLocation == index
                                        ? Colors.white
                                        : Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => model.openMaps(),
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
                  'Get Directions',
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
