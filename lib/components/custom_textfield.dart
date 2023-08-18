import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.labelText,
      required this.icon,
      required this.isobscureText,
      this.suffixIcon,
      required this.type});

  final String labelText;
  final IconData icon;
  final bool isobscureText;
  Widget? suffixIcon;
  final type;

  bool isEmail(String input) => EmailValidator.validate(input);

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //initialValue: "Email",
      validator: (value) {
        switch (type) {
          case "user":
            return value!.isEmpty ? "This field should be valid" : null;

          case "email":
            return value!.isEmpty && !isEmail(value)
                ? "This field should be valid"
                : null;
          case "phone":
            return value!.isEmpty && !isPhone(value)
                ? "This field should be valid"
                : null;
          case "password":
            return value!.isEmpty ? "This field should be valid" : null;
        }
      },
      obscureText: isobscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.purple),
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        //  hintText: "Enter email",
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
            borderRadius: BorderRadius.circular(6)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
