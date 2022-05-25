import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void _onPressed() {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance.collection("doctors").doc(firebaseUser!.uid).set({
    "name": "Humza Khan",
    "age": 21,
    "Time Avaliable": "10:00 A.M to 12:00 PM",
  }).then((_) {
    print("success!");
  });
}
