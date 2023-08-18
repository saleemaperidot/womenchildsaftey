import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:womensaftey/Pages/child_register.dart';
import 'package:womensaftey/Pages/parent_register.dart';
import 'package:womensaftey/Pages/user_register.dart';
import 'package:womensaftey/components/customButton.dart';
import 'package:womensaftey/components/custom_textfield.dart';

class RegisterUser extends StatelessWidget {
  const RegisterUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            buttonText: "Child Register",
            onpressed: ChildRegister(),
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            buttonText: "Parent Register",
            onpressed: ParentRegister(),
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            buttonText: "Indepentent women",
            onpressed: UserRegister(),
          )
        ],
      )),
    );
  }
}
