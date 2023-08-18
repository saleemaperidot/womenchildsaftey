import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/login.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('type', 'null');
              Get.offAll(Login());
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        child: Center(child: Text("User Home")),
      )),
    );
  }
}
