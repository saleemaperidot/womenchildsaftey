import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womensaftey/models/user_model/user_model.dart';
import 'package:womensaftey/services/firebaseservises.dart';
import 'package:womensaftey/utils/firebase.dart';

class FirebaseController extends GetxController {
  RxList<dynamic> listofguardians = [].obs;
  Future createFirebaseUser(
      {required String email, required String password}) async {
    try {
      final result = await FirebaseServices()
          .registerWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future getUsersGuadientList() async {
    List<String> guardians = [];
    listofguardians.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      final g1 = value['parentEmail'];
      final g2 = value['secondParent'];
      final g3 = value['alternativeguardian'];
      guardians.addAll([g1, g2, g3]);

      final CollectionReference snapshot =
          await FirebaseFirestore.instance.collection('users');

      final guad1 = snapshot.where('email', isEqualTo: g1).get().then((value) {
        final usename = value.docs[0]['username'];
        final id = value.docs[0]['id'];
        Map<String?, String?> gardianA = {'username': usename, 'id': id};
        listofguardians.add(gardianA);
      });
      final guad2 = snapshot.where('email', isEqualTo: g2).get().then((value) {
        final usename = value.docs[0]['username'];
        final id = value.docs[0]['id'];
        Map<String?, String?> gardianB = {'username': usename, 'id': id};
        listofguardians.add(gardianB);
      });
      final guad3 = snapshot.where('email', isEqualTo: g3).get().then((value) {
        final usename = value.docs[0]['username'];
        final id = value.docs[0]['id'];
        Map<String?, String?> gardianC = {'username': usename, 'id': id};
        listofguardians.add(gardianC);
      });

      /// print("print(gua1);+$guad1\n$guad2\n$guad2");
    });
    print(listofguardians);
    return listofguardians;
  }

  Future getchildsforGardian() async {
    listofguardians.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    final useremail = pref.getString('email');
    print("sharedprefusename$useremail");
    await FirebaseFirestore.instance
        .collection('users')
        .where('alternativeguardian', isEqualTo: useremail)
        .get()
        .then((value) {
      listofguardians.addAll(value.docs);
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where('parentEmail', isEqualTo: useremail)
        .get()
        .then((value) {
      listofguardians.addAll(value.docs);
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where('secondParent', isEqualTo: useremail)
        .get()
        .then((value) {
      listofguardians.addAll(value.docs);
    });
  }
}
