import 'package:flutter/material.dart';

TextStyle customTextStyle =
    TextStyle(color: Colors.purple, fontSize: 30, fontWeight: FontWeight.bold);

InputDecoration textfieldDecoration(
    {required String labeltext,
    required Widget prefixicon,
    required Widget suffixicon}) {
  return InputDecoration(
    labelText: labeltext,
    labelStyle: TextStyle(color: Colors.purple),
    prefixIcon: prefixicon,
    suffixIcon: suffixicon,
    //  hintText: "Enter email",
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple),
        borderRadius: BorderRadius.circular(6)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purple),
      borderRadius: BorderRadius.circular(6),
    ),
  );
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
      minimumSize: Size(400, 48),
      elevation: 3,
      backgroundColor: Colors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ));
}
