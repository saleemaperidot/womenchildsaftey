import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womensaftey/Pages/call_page.dart';
import 'package:womensaftey/Pages/complaints.dart';
import 'package:womensaftey/Pages/contact.dart';
import 'package:womensaftey/Pages/login.dart';
import 'package:womensaftey/Pages/message_page.dart';
import 'package:womensaftey/Pages/my_home_page.dart';
import 'package:womensaftey/Pages/trusted_contacts.dart';
import 'package:womensaftey/widgets/custom_bottomnavigation.dart';
import 'package:womensaftey/widgets/custom_carosel_slider.dart';
import 'package:womensaftey/widgets/emergency_call.dart';
import 'package:womensaftey/widgets/random_quotes.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final pages = [
    MyHome(),
    Message(type: "child"),
    Call(),
    TrustedContacts(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, value, _) {
            return pages[value];
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
