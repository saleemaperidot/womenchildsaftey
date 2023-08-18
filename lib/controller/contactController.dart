import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_contacts_model.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_repo/trusted_repo.dart';

class ContactController extends GetxController {
  RxList<TrustedContact> contactList = <TrustedContact>[].obs;
  Rx<bool> isInserated = false.obs;

  getTrustedContacts() async {
    // contactList.clear();
    List<TrustedContact> _contactList = await TrustedRepo.instance.getContact();
    print(_contactList);
    // print(_contactList[0].name + "" + _contactList[0].phoneNumber);
    contactList.clear();
    contactList.addAll(_contactList);
  }

  Future<bool> addTrustedContact(TrustedContact trustedContact) async {
    isInserated.value = false;
    final int response = await TrustedRepo.instance.insert(trustedContact);
    print(response);
    if (response == 1) {
      isInserated.value = true;
      return true;
    } else {
      return false;
    }
  }

  deleteContact(String id) async {
    await TrustedRepo.instance.delete(id);
    // await getTrustedContacts();
  }
}
