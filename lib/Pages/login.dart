import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womensaftey/Pages/register_user.dart';
import 'package:womensaftey/components/custom_textfield.dart';
import 'package:womensaftey/home.dart';
import 'package:womensaftey/parent_home.dart';
import 'package:womensaftey/user_home.dart';
import 'package:womensaftey/utils/custom_style.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  bool obsquratext = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isobsquare = true;

  bool isEmail(String input) => EmailValidator.validate(input);

  // @override
  // void initState() async {
  //   // TODO: implement initState
  //   super.initState();
  //   Get.dialog(CircularProgressIndicator());
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? type = pref.getString('type');
  //   if (type == null) {
  //     Get.to(Login());
  //   } else if (type == 'parent') {
  //     Get.to(ParentHome());
  //   } else if (type == 'child') {
  //     Get.to(Home());
  //   } else if (type == 'user') {
  //     Get.to(UserHome());
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      height: 20,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: isobsquare,
                      validator: (value) {
                        return value!.isEmpty && value.length < 6
                            ? "Enter valid password with atleat 6 carecters"
                            : null;
                      },
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
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                              print(credential);

                              if (credential.user!.uid != null) {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(credential.user!.uid)
                                    .get()
                                    .then((value) {
                                  if (value['type'] == 'user') {
                                    print("User credentilas");
                                    pref.setString("type", "user");
                                    pref.setString('email', email.text);
                                    Get.offAll(UserHome());
                                  } else if (value['type'] == 'child') {
                                    pref.setString("type", "child");
                                    pref.setString('email', email.text);
                                    Get.offAll(Home());
                                  } else if (value['type'] == 'parent') {
                                    pref.setString("type", "parent");
                                    pref.setString('email', email.text);
                                    Get.offAll(ParentHome());
                                  }
                                });
                                // await Helper.getUserLoggedInSharedPreference();
                              } else {
                                print("no credential");
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          } else {
                            print("cant loged in");
                          }
                          //   try {
                          //final user = FirebaseAuth.instance.currentUser!.uid;
                          // UserCredential userCredential = await FirebaseAuth
                          //    .instance
                          //    .signInWithEmailAndPassword(
                          //    email: email.text, password: password.text);
                          //  print(userCredential);
                          // print(user);
                          //   if (userCredential.user != null) {
                          //     print(userCredential.user!.uid);

                          //     SharedPreferences _pref =
                          //         await SharedPreferences.getInstance();

                          //     FirebaseFirestore.instance
                          //         .collection('users')
                          //         .doc(FirebaseAuth.instance.currentUser!.uid)
                          //         .get()
                          //         .then((value) {
                          //       print("login credential");
                          //       if (value['type'] == 'parent') {
                          //         print(value['type']);
                          //         _pref.setString('type', 'parent');
                          //         Get.to(ParentHome());
                          //       } else if (value['type'] == 'child') {
                          //         _pref.setString('type', 'child');
                          //         Get.to(Home());
                          //       } else if (value['type'] == 'user') {
                          //         _pref.setString('type', 'user');
                          //         Get.to(UserHome());
                          //       } else {
                          //         Get.dialog(Container(
                          //           child: Text('cant Login'),
                          //         ));
                          //       }
                          //     });
                          //   } else {
                          //     print('cant login');
                          //   }
                          //     } catch (e) {
                          //     print(e);
                          //on FirebaseException catch (e) {

                          // if (e.code == 'user-not-found') {
                          //   print("No user found for email");
                          // } else if (e.code == 'wrong-password') {
                          //   print("wrong password");
                          // }
                        }
                        //  Get.to(Home());
                        //  },
                        ,
                        child: Text("Login"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text("forgot password?"),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(RegisterUser());
                            },
                            child: Text("Register"))
                      ],
                    )
                  ]),
            ),
          ),
        ),
      )),
    );
  }
}
