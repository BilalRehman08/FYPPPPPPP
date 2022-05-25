import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../colorScheme.dart';



class DoctorInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir',
      ),
      home: doctorInfoPage(),
    );
  }
}

class doctorInfoPage extends StatefulWidget {
  @override
  _doctorInfoPageState createState() => _doctorInfoPageState();
}

class _doctorInfoPageState extends State<doctorInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [getStartedColorStart, getStartedColorEnd],
          begin: Alignment(0, -1.15),
          end: Alignment(0, 0.1),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/images/docinfo/bg1.png'),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: bgColor,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Pending Appointments",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            
              
                  

                  
                
              
   
                            // acceptTime("13", "MAY", "Consultation",
                            //     "Sunday 9 am to 11.30 am"),
                            // acceptTime("14", "MAY", "Consultation",
                            //     "Monday 10 am to 12.30 am"),
                            // acceptTime("1", "JUN", "Consultation",
                            //     "Wednesday 8 am to 12.30 pm"),
                            // acceptTime("3", "JUN", "Consultation",
                            //     "Friday 8 am to 1 am"),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('doctors data').snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }
                        
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text("Loading");
                                }
                        
                                return Expanded(
                                  child: ListView(
                                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                      return InkWell
                                      (
                                        onTap: (){
                                          showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("ACCEPT OR REJECT"),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                document.reference.update({"status": "accepted"});
                                Navigator.pop(context);
                              },
                              child: Text("Accept", style: TextStyle(color: Colors.green),)),
                            SizedBox(width: 25,),
                            InkWell(
                              onTap: (){
                                document.reference.update({"status": "rejected"});
                                Navigator.pop(context);
                              },
                              child: Text("Reject", style: TextStyle(color: Colors.red),)),
                          ],
                        
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                    );
                                        },
                                        child:data['status']!="rejected"?acceptTime(data['day'],data['month'], data['Patient Name'], data['reason'],):SizedBox());
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container acceptTime(
      String date, String month, String slotType, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: docContentBgColor),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: dateBgColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$date",
                    style: TextStyle(
                        color: dateColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "$month",
                    style: TextStyle(
                        color: dateColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "$slotType",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 60),
                    Icon(Icons.alarm),
                    SizedBox(width: 20),
                    Icon(Icons.alarm_off_outlined)
                  ],
                ),
                Text(
                  "$time",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
