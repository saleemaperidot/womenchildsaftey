import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sensors/sensors.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womensaftey/controller/contactController.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_contacts_model.dart';
import 'package:womensaftey/utils/permission_set.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  AccelerometerEvent? _lastEvent;
  final double shakeThreshold = 3.0;
  //late ShakeDetector detector;
  void initState() {
    // TODO: implement initState

    super.initState();
    accelerometerEvents.listen((event) {
      if (_lastEvent == null) {
        _lastEvent = event;
        return;
      }
      double deltaX = _lastEvent!.x - event.x;
      double deltaY = _lastEvent!.y - event.y;
      double deltaZ = _lastEvent!.z - event.z;

      double acceleration = deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ;

      if (acceleration > shakeThreshold * shakeThreshold) {
        _lastEvent = null; // Reset to avoid repeated triggering
        sendLocation();
        print("phone shaked");
      }
    });
  }

  String? username;

  void getUserDtails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString('email');
    print(username);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getUserDtails();
      },
    );

    return Container(
      child: Center(
        child: Text("Welcome $username"),
      ),
    );
  }

  void sendLocation() async {
    ContactController _contactController = Get.put(ContactController());
    _contactController.getTrustedContacts();
    isPermissionEnabeled();
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true);
      List<TrustedContact> contact = _contactController.contactList;
      List<String> phoneNumber = [];
      for (var number in contact) {
        phoneNumber.add(number.phoneNumber);
      }
      print(phoneNumber);
      // contact[1].phoneNumber;
      final message =
          "'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}'";
      phoneNumber.isNotEmpty
          ? sendMessage(message, phoneNumber)
          : Get.defaultDialog(
              content: Text("You should add at;east one trusted contact"));

      position != null
          ? Get.defaultDialog(
              content: Center(
              child: Container(
                child: Text("location send"),
              ),
            ))
          : Get.defaultDialog(
              content: Center(
              child: Container(
                child: Text("sending"),
              ),
            ));
      ;
      print(position);
    } catch (e) {
      Get.defaultDialog(
          content: Center(
        child: Container(
          child: Text("something went wrong"),
        ),
      ));
    }
  }

  void sendMessage(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}
