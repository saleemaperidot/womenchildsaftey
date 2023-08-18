import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:womensaftey/Pages/contact.dart';
import 'package:womensaftey/controller/contactController.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_contacts_model.dart';

import 'package:womensaftey/utils/custom_style.dart';
import 'package:get/get.dart';

class TrustedContacts extends StatelessWidget {
  TrustedContacts({super.key});
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  final ContactController contactController = Get.put(ContactController());
  // final contactController = Get.find<ContactController>();
//List<TrustedContact> contact=contactController.contactList;

  @override
  Widget build(BuildContext context) {
    contactController.getTrustedContacts();
    List<TrustedContact> contact = contactController.contactList;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(ContactPage());
              },
              child: Text("Add Trusted Contacts"),
              style: buttonStyle(),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  print(contact.length);
                  return contact.length > 0
                      ? ListTile(
                          leading: CircleAvatar(
                            child: Text(contact[index].name[0]),
                          ),
                          title: Text(contact[index].name),
                          subtitle: Text(contact[index].phoneNumber),
                          trailing: Container(
                              width: 100,
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        _makePhoneCall(
                                            contact[index].phoneNumber);
                                      },
                                      child: Icon(Icons.call,
                                          color: Colors.purple)),
                                  InkWell(
                                    onTap: () {
                                      contactController
                                          .deleteContact(contact[index].id);
                                      contactController.getTrustedContacts();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              )),
                        )
                      : Center(
                          child: Container(
                            child: Text("No Trusted contacts"),
                          ),
                        );
                },
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemCount: contact.length,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
