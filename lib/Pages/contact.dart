import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:womensaftey/Pages/trusted_contacts.dart';
import 'package:womensaftey/controller/contactController.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_contacts_model.dart';
import 'package:womensaftey/models/trusted_contact_model/trusted_repo/trusted_repo.dart';

class ContactPage extends StatefulWidget {
  ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contact = [];

  Future<void> askpermission() async {
    PermissionStatus permissionstatus = await getContactPermission();
    if (permissionstatus == PermissionStatus.granted) {
      getAllContacts();
    } else {
      handileInvalidPermissions(permissionstatus);
    }
  }

  getAllContacts() async {
    List<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contact = _contacts;
    });
  }

  handileInvalidPermissions(PermissionStatus permissionstatus) {
    if (permissionstatus == PermissionStatus.denied) {
      Get.defaultDialog(content: Text("Permission deneid"));
    } else if (permissionstatus == PermissionStatus.permanentlyDenied) {
      Get.defaultDialog(content: Text("Permission deneid by user"));
    }
  }

  Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionstatus = await Permission.contacts.request();
      return permissionstatus;
    } else {
      return permission;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    askpermission();
  }

  List<Contact> filtered = [];

  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: CupertinoSearchTextField(
                  controller: searchcontroller,
                  onChanged: (value) {
                    filtered = [];
                    contact.forEach((element) {
                      if (element.displayName!.toLowerCase().contains(value)) {
                        setState(() {
                          filtered.add(element);
                        });
                      } else {}
                      print(filtered);
                    });
                  },
                )),
            Expanded(
              child: filtered.isNotEmpty
                  ? MyContactList(contact: filtered)
                  : MyContactList(contact: contact),
            ),
          ],
        ),
      ),
    );
  }
}

class MyContactList extends StatelessWidget {
  MyContactList({
    super.key,
    required this.contact,
  });
  ContactController contactController = Get.put(ContactController());
  final List<Contact> contact;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            final String id = (index + 1).toString();
            final name = contact[index].displayName!;
            final phoneNumber = contact[index].phones!.elementAt(0).value;

            await contactController.addTrustedContact(
                TrustedContact(id: id, name: name, phoneNumber: phoneNumber!));
            contactController.isInserated.value
                ? Get.off(TrustedContacts())
                : CircularProgressIndicator();
          },
          child: ListTile(
            leading: contact[index].avatar == null
                ? CircleAvatar(
                    backgroundColor: Colors.pink,
                    child: Text(contact[index].displayName!.toString()[0]))
                : CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
            title: Text(contact[index].givenName!),
            //subtitle: Text(contact[index].phones![index].value ?? ""),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: contact.length,
    );
  }
}
