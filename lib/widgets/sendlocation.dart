import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:womensaftey/controller/contactController.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_contacts_model.dart';
import 'package:womensaftey/utils/custom_style.dart';
import 'package:womensaftey/utils/permission_set.dart';

class SendLocation extends StatelessWidget {
  const SendLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 200,
      child: InkWell(
        onTap: () => Get.bottomSheet(BottomSheetWidget()),
        child: Card(
          elevation: 10,
          color: Colors.purple.shade50,
          child: Row(
            children: [
              Container(
                width: 150,
                height: 50,
                child: ListTile(
                  title: Text("Send Location"),
                  subtitle: Text("Share location"),
                ),
              ),
              Container(
                  height: 200,
                  child: Image(
                      fit: BoxFit.cover,
                      // width: 100,
                      image: AssetImage("assets/safteyloc.png")))
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.purple.shade100,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      onClosing: () {
        Get.off(BottomSheetWidget());
      },
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "SEND EMERGENCY ALERTS ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.yellow,
                          Colors.redAccent,
                          Colors.purpleAccent
                          //add more colors
                        ]),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(
                                  0, 0, 0, 0.57), //shadow for button
                              blurRadius: 5) //blur radius of shadow
                        ]),
                    child: TextButton(
                      //style: buttonStyle().copyWith(),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                        //make color or elevated button transparent
                      ),
                      onPressed: () {
                        sendLocation();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("SEND LOCATION"),
                          Icon(Icons.location_city)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.redAccent,
                          Colors.purpleAccent,
                          Colors.yellow,
                          //add more colors
                        ]),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(
                                  0, 0, 0, 0.57), //shadow for button
                              blurRadius: 5) //blur radius of shadow
                        ]),
                    width: 200,
                    child: TextButton(
                      // style: buttonStyle(),
                      onPressed: () {
                        //   sendMessage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("SEND SMS"), Icon(Icons.message)],
                      ),
                    ),
                  )
                ]),
          ),
        );
      },
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
