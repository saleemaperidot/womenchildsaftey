import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

ValueNotifier<int> notifier = ValueNotifier<int>(0);

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, _) {
        return BottomNavigationBar(
            currentIndex: value,
            selectedItemColor: Colors.pink.shade100,
            unselectedItemColor: Colors.pink.shade400,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              notifier.value = index;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined), label: "message"),
              BottomNavigationBarItem(icon: Icon(Icons.call), label: "call"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.contact_phone), label: "contact"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: "Profile")
            ]);
      },
    );
  }
}
