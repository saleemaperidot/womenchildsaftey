import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:womensaftey/utils/quotes.dart';

class RandomQuotes extends StatelessWidget {
  const RandomQuotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // leading: Icon(Icons.menu_outlined),
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.85,
            child: CarouselSlider.builder(
                itemCount: radomQuotes.length,
                itemBuilder: (context, index, realIndex) => radomQuotes[index],
                options: CarouselOptions(
                    disableCenter: true,
                    pageSnapping: false,
                    autoPlay: true,
                    viewportFraction: 1)),
          ),
          Icon(Icons.settings),
        ]);
  }
}
