import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:womensaftey/controller/messagecontroller.dart';

import 'package:womensaftey/models/message_model/message_model.dart';
import 'package:womensaftey/services/chatServises.dart';
import 'package:womensaftey/utils/googlemap.dart';

class SingleMessageScreen extends StatelessWidget {
  SingleMessageScreen(
      {super.key, required this.gardianName, required this.guardianId});
  final String gardianName;
  final String guardianId;
  TextEditingController _messageTextFieldController = TextEditingController();
  MessageController _messageController = Get.put(MessageController());
  bool isMe = false;
  @override
  Widget build(BuildContext context) {
    _messageController.getAllMessages(
        FirebaseAuth.instance.currentUser!.uid, guardianId);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.pink,
          title: Text(gardianName.toUpperCase()),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Obx(
                  () => ListView.separated(
                    reverse: true,
                    dragStartBehavior: DragStartBehavior.down,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: _messageController.messageList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      print("_message${_messageController.messageList.length}");
                      String messagebody =
                          _messageController.messageList[index]['message'];

                      final data = _messageController.messageList[index];

                      String type = data['typeOfMessage'] ?? "";

                      // final time = data['datetime'].DateTime();
                      //DateFormat('HH:mm').format(time);
                      DateTime dateTime = DateTime.parse(data['datatime']);
                      final time = DateFormat('HH:mm').format(dateTime);
                      data['senderId'] == FirebaseAuth.instance.currentUser!.uid
                          ? isMe = true
                          : isMe = false;
                      print(isMe);
                      print("${data['senderId']}");
                      print(FirebaseAuth.instance.currentUser!.uid);
                      print("messagebody$messagebody");
                      return Padding(
                          padding: const EdgeInsets.all(8),
                          child: isMe
                              ? Positioned(
                                  right: 10,
                                  child: Container(
                                    constraints: BoxConstraints(
                                        //maxWidth: 40,
                                        minHeight: 60,
                                        minWidth: 70),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        type == 'maplink'
                                            ? InkWell(
                                                onTap: () {
                                                  shareLocation();
                                                },
                                                child: Image(
                                                    fit: BoxFit.cover,
                                                    width: 200,
                                                    height: 100,
                                                    image: NetworkImage(
                                                        "https://i.stack.imgur.com/DmAyW.png")),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.pink
                                                      .shade200, // Background color of the container
                                                  borderRadius: BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25),
                                                      topRight:
                                                          Radius.circular(25),
                                                      bottomRight:
                                                          Radius.circular(25),
                                                      bottomLeft: Radius.elliptical(
                                                          -1,
                                                          -1)), // Half of width or height for a perfect circle
                                                  border: Border.all(
                                                    color: Colors
                                                        .pink, // Border c89+olor
                                                    width: 2.0, // Border width
                                                  ),
                                                ),
                                                width: 300,
                                                height: 69,
                                                //color: Colors.pink,
                                                child: ListTile(
                                                  title: Text(messagebody),
                                                  subtitle: Text(time),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ))
                              : Positioned(
                                  left: 10,
                                  child: type == 'maplink'
                                      ? InkWell(
                                          onTap: () {
                                            shareLocation();
                                          },
                                          child: Image(
                                              fit: BoxFit.cover,
                                              width: 200,
                                              height: 100,
                                              image: NetworkImage(
                                                  "https://i.stack.imgur.com/DmAyW.png")),
                                        )
                                      : Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.purple
                                                        .shade200, // Background color of the container
                                                    borderRadius: BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(25),
                                                        topRight:
                                                            Radius.circular(25),
                                                        bottomLeft:
                                                            Radius.circular(25),
                                                        bottomRight:
                                                            Radius.elliptical(
                                                                23,
                                                                -10)), // Half of width or height for a perfect circle
                                                    border: Border.all(
                                                      color: Colors
                                                          .purple, // Border c89+olor
                                                      width:
                                                          2.0, // Border width
                                                    ),
                                                  ),
                                                  width: 300,
                                                  height: 69,
                                                  // color: Colors.blue,
                                                  child: ListTile(
                                                    title: Text(messagebody),
                                                    subtitle: Text(time),
                                                  )),
                                            ],
                                          ),
                                        ),
                                ));
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // color: Colors.red,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        child: Text("+"),
                        // color: Colors.blue,
                        onPressed: () {
                          Get.bottomSheet(
                              //  paddingAll(8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 10,
                              backgroundColor: Colors.white,
                              bottomsheetColumn(guardianId: guardianId));
                        },
                        // icon: Icon(Icons.add),
                        // color: Colors.purple,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            //color: Colors.grey,
                            ),
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: TextFormField(
                            controller: _messageTextFieldController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type message"),
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            ChatWithGardianServises().chatting(MessageModel(
                              senderId: FirebaseAuth.instance.currentUser!.uid,
                              recieverId: guardianId,
                              message: _messageTextFieldController.text,
                              datatime: DateTime.now().toString(),
                              typeOfMessage: "text",
                            ));
                            _messageController.getAllMessages(
                                FirebaseAuth.instance.currentUser!.uid,
                                guardianId);
                            _messageTextFieldController.text = "";
                          },
                          child: Icon(color: Colors.blue, Icons.send))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class bottomsheetColumn extends StatelessWidget {
  bottomsheetColumn({super.key, required this.guardianId});
  final guardianId;

  MessageController _messageController = Get.put(MessageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        InkWell(
          onTap: () async {
            final message = await getUrl();

            ChatWithGardianServises().chatting(MessageModel(
                senderId: FirebaseAuth.instance.currentUser!.uid,
                recieverId: guardianId,
                message: message,
                datatime: DateTime.now().toString(),
                typeOfMessage: "maplink"));
            _messageController.getAllMessages(
                FirebaseAuth.instance.currentUser!.uid, guardianId);

            // Get.to(CircularProgressIndicator());
            print("share location called");
            //store in firebase message
            Get.back();
            // sendSMS(message: message, recipients: recipients)
            // shareLocation();
          },
          child: ListTile(
            leading: Icon(color: Colors.blue, Icons.location_on),
            title: Text("Location"),
          ),
        ),
        ListTile(
          leading: Icon(color: Colors.blue, Icons.image),
          title: Text("Image"),
        ),
        ListTile(
          leading: Icon(color: Colors.blue, Icons.camera),
          title: Text("Camera"),
        ),
        ListTile(
          leading: Icon(color: Colors.blue, Icons.document_scanner),
          title: Text("Documents"),
        ),
        ListTile(
          leading: Icon(color: Colors.blue, Icons.contact_phone),
          title: Text("contact"),
        ),
      ]),
    );
  }
}
