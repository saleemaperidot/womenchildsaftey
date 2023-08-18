import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:womensaftey/widgets/custom_carosel_slider.dart';
import 'package:womensaftey/widgets/emergency_call.dart';
import 'package:womensaftey/widgets/explore_livestyle.dart';
import 'package:womensaftey/widgets/random_quotes.dart';
import 'package:womensaftey/widgets/sendlocation.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        //  physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        // mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RandomQuotes(),
          SizedBox(
            height: 15,
          ),
          CustomCaroselSlider(),
          SizedBox(
            height: 20,
          ),
          EmergencyCall(),
          SizedBox(
            height: 15,
          ),
          Text(
            "Explore LiveStyle",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          ExploreLiveStyle(),
          SendLocation()
        ],
      ),
    );
  }
}
