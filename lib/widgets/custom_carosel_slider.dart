import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:womensaftey/Pages/webview_page.dart';
import 'package:womensaftey/utils/quotes.dart';

List<String> urls = [
  "https://www.internationalwomensday.com/",
  "https://www.womenshealthmag.com/",
  "https://un-women.medium.com/women-leaders-we-admire-46ee179ec4ca",
  "https://www.startupindia.gov.in/content/sih/en/women_entrepreneurs.html"
];

class CustomCaroselSlider extends StatelessWidget {
  const CustomCaroselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: CarouselSlider.builder(
        options: CarouselOptions(
            clipBehavior: Clip.none,
            height: MediaQuery.of(context).size.width * 0.45,
            autoPlay: true,
            aspectRatio: 0.2),
        itemCount: caroselimages.length,
        itemBuilder: (context, index, realIndex) {
          return Padding(
            padding: EdgeInsets.only(left: 10),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => WebViewPage(
                          url: urls[index],
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      //shape: BoxShape.circle
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(caroselimages[index]))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          caroselString[index],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
