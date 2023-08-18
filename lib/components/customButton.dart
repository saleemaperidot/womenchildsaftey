import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.buttonText, required this.onpressed});
  final String buttonText;
  final Widget onpressed;
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(400, 48),
            elevation: 3,
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
        onPressed: () {
          Get.to(onpressed);
        },
        child: Text(buttonText),
      ),
    );
  }
}
