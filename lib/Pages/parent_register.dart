import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:womensaftey/components/custom_textfield.dart';
import 'package:womensaftey/models/user_model/user_model.dart';
import 'package:womensaftey/services/firebaseservises.dart';
import 'package:womensaftey/utils/custom_style.dart';

import 'login.dart';

class ParentRegister extends StatefulWidget {
  const ParentRegister({super.key});

  @override
  State<ParentRegister> createState() => _ParentRegisterState();
}

class _ParentRegisterState extends State<ParentRegister> {
  bool isobsquare = true;
  TextEditingController childemail = TextEditingController();
  TextEditingController usename = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  final formkey = GlobalKey<FormState>();
  List<String> child = [];
  bool isEmail(String input) => EmailValidator.validate(input);

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PARENT REGISTER",
              style: customTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                return value!.isEmpty ? "Enter a valid username" : null;
              },
              controller: usename,
              obscureText: false,
              decoration: textfieldDecoration(
                  labeltext: "username",
                  prefixicon: Icon(
                    Icons.account_box,
                  ),
                  suffixicon: SizedBox()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                return value!.isEmpty && !isPhone(value)
                    ? "Enter valid phone"
                    : null;
              },
              controller: phonenumber,
              obscureText: false,
              decoration: textfieldDecoration(
                  labeltext: "phone number",
                  prefixicon: const Icon(
                    Icons.phone,
                  ),
                  suffixicon: SizedBox()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                return value!.isEmpty && !isEmail(value)
                    ? "Enter valid Email"
                    : null;
              },
              controller: email,
              obscureText: false,
              decoration: textfieldDecoration(
                  labeltext: "Email",
                  prefixicon: Icon(
                    Icons.email,
                  ),
                  suffixicon: SizedBox()),
            ),
            SizedBox(
              height: 10,
            ),

            // TextFormField(
            //   maxLength: null,
            //   minLines: null,
            //   controller: childemail,
            //   validator: (value) {
            //     return value!.isEmpty && !isEmail(value)
            //         ? "Enter valid Email"
            //         : null;
            //   },
            //   obscureText: false,
            //   decoration: textfieldDecoration(
            //       labeltext: "child email",
            //       prefixicon: Icon(
            //         Icons.account_box,
            //       ),
            //       suffixicon: IconButton(
            //           color: Colors.blue,
            //           onPressed: () {
            //             setState(() {
            //               child.add(childemail.text);
            //             });

            //             childemail.clear();
            //           },
            //           icon: Icon(
            //             Icons.add,
            //             semanticLabel: "Add more child",
            //           ))),
            // ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                return value!.isEmpty && value.length < 6
                    ? "Enter valid password with atleat 6 carecters"
                    : null;
              },
              controller: password,
              obscureText: isobsquare,
              decoration: textfieldDecoration(
                labeltext: "password",
                prefixicon: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.key,
                  ),
                ),
                suffixicon: InkWell(
                  onTap: () {
                    setState(() {
                      isobsquare = !isobsquare;
                    });
                  },
                  child: isobsquare
                      ? Icon(Icons.remove_red_eye)
                      : Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // CustomTextField(
            //   type: "retypepass",
            //   labelText: "Retype password",
            //   icon: Icons.key,
            //   isobscureText: true,
            // ),
            SizedBox(
              height: 10,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 48),
                    elevation: 3,
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    Get.dialog(Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    ));
                    FirebaseServices servise = FirebaseServices();
                    final result = servise
                        .registerWithEmailAndPassword(
                            email: email.text, password: password.text)
                        .then((value) async {
                      print(value);

                      final db = FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid);
                      await db
                          .set(UserModel(
                                  id: FirebaseAuth.instance.currentUser!.uid,
                                  email: email.text,
                                  password: password.text,
                                  phone: phonenumber.text,
                                  username: usename.text,
                                  type: 'parent',
                                  childEmail: childemail.text)
                              .toJson())
                          .whenComplete(() => Get.to(Login()));
                    });
                    // firebasecollection.doc()

                    print(result);
                  }
                },
                child: Text("Register"),
              ),
            ),
            // CustomTextField(labelText: "", icon: icon, isobscureText: isobscureText)
          ],
        ),
      )),
    );
  }
}
