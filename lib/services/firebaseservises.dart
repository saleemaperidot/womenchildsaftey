import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_contacts_model.dart';
import 'package:womensaftey/utils/firebase.dart';

class FirebaseServices {
  Future registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      return user;
    } catch (e) {
      print(e);
    }
  }

  List<TrustedContact> getAllUsersFromFirebase() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {});
    return [];
  }
}
