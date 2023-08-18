import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreLiveStyle extends StatelessWidget {
  const ExploreLiveStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 100,
      child: ListView(
        padding: EdgeInsets.all(15),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(),
        children: [
          customCard(
            icon: Icons.local_police_sharp,
            text: "PoliceStation",
            color: Colors.yellow,
            url: "police station near me",
          ),
          SizedBox(
            width: 20,
          ),
          customCard(
            icon: Icons.local_hospital,
            text: "Hospital",
            color: Colors.orange,
            url: "hospitals near me",
          ),
          SizedBox(
            width: 20,
          ),
          customCard(
            icon: Icons.local_pharmacy,
            text: "pharmacy",
            color: Colors.red,
            url: "pharmacy near me",
          ),
          SizedBox(
            width: 20,
          ),
          customCard(
            icon: Icons.bus_alert_sharp,
            text: "BusStation",
            color: Colors.indigo,
            url: "Bus stations near me",
          ),
          SizedBox(
            width: 20,
          ),
          customCard(
            icon: Icons.fire_truck_sharp,
            text: "firestation",
            color: Colors.white,
            url: "fire station near me",
          )
        ],
      ),
    );
  }
}

class customCard extends StatelessWidget {
  customCard(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      required this.url});
  final IconData icon;
  final Color color;
  final String text;
  final String url;

  static Future<void> launchmap(String url) async {
    String googleUrl = "https://www.google.com/maps/search/$url";
    final Uri _uri = Uri.parse(googleUrl);
    try {
      await launchUrl(_uri);
    } catch (e) {
      print("cant launch url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print(url);
            launchmap(url);
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  Colors.blue,
                  Colors.green,
                  Colors.purple.shade300,
                ]),
                //color: Colors.purple,
                borderRadius: BorderRadius.circular(20)),
            width: 70,
            height: 89,
            child: IconButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple)),
                onPressed: () {
                  print(url);
                  launchmap(url);
                },
                icon: Icon(
                  size: 40,
                  icon,
                  color: color,
                )),
          ),
        ),
        Text(text)
      ],
    );
  }
}
