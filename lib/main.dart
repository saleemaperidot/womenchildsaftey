import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womensaftey/Pages/login.dart';
import 'package:womensaftey/home.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_contacts_model.dart';
import 'package:womensaftey/parent_home.dart';
import 'package:womensaftey/user_home.dart';
import 'package:womensaftey/utils/customNotification.dart';
import 'package:womensaftey/utils/permission_set.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await smsPermissionGranded();
  await initializeService();
  if (!Hive.isAdapterRegistered(TrustedContactAdapter().typeId)) {
    Hive.registerAdapter(TrustedContactAdapter());
  }
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String? type = preferences.getString('type');

  runApp(MyApp(
    type: type,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.type});
  String? type;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: type == 'parent'
            ? ParentHome()
            : type == 'child'
                ? Home()
                : type == 'user'
                    ? UserHome()
                    : Login());
  }
}
