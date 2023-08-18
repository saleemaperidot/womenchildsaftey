import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womensaftey/Pages/message_page.dart';

import 'Pages/login.dart';

class ParentHome extends StatelessWidget {
  const ParentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade500,
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString('type', 'null');
                Get.offAll(Login());
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: Message(
          type: "parent",
        ));
  }
}
