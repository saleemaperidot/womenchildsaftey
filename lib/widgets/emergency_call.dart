import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCall extends StatelessWidget {
  EmergencyCall({super.key});

  final String phoneNumber =
      'tel:+91-9633784925'; // Replace with the desired phone number.

  void _callNumber() async {
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      // Handle the case when the phone call couldn't be made.
      print('Could not make the phone call.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: () {
              _callNumber();
            },
            child: customWidgetEmergency(
              ButtonText: "0-1-5",
              icon: Icons.home,
              mainHeading: "Active Emegency",
              subHeading: "Call 0-1-5 for Emergency",
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              _callNumber();
            },
            child: customWidgetEmergency(
              ButtonText: "1-1-2",
              icon: Icons.warning_amber_outlined,
              mainHeading: "Ambulance",
              subHeading: "Call 1-1-2 for Ambulance",
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              _callNumber();
            },
            child: customWidgetEmergency(
              ButtonText: "1-1-5",
              icon: Icons.warning_amber_outlined,
              mainHeading: "NACTA",
              subHeading: "Call NACTA to register complaints",
            ),
          ),
        ],
      ),
    );
  }
}

class customWidgetEmergency extends StatelessWidget {
  customWidgetEmergency(
      {super.key,
      required this.ButtonText,
      required this.icon,
      required this.mainHeading,
      required this.subHeading});
  final IconData icon;
  final String mainHeading;
  final String subHeading;
  final String ButtonText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(15),
        // color: Colors.yellow,
        width: 250,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.yellow,
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.orange,
              Colors.yellow,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            Text(
              mainHeading,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(subHeading),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {},
                child: Text(ButtonText))
          ],
        ),
      ),
    );
  }
}
