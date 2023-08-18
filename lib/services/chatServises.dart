import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:womensaftey/models/message_model/message_model.dart';

class ChatWithGardianServises {
  void chatting(MessageModel _messageModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_messageModel.senderId)
        .collection('message')
        .doc(_messageModel.recieverId)
        .collection('chats')
        .add(_messageModel.toJson());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(_messageModel.recieverId)
        .collection('message')
        .doc(_messageModel.senderId)
        .collection('chats')
        .add(_messageModel.toJson());
  }

  Future<List<QueryDocumentSnapshot<Object?>>> geMessagesFromFirestore(
      String senderId, String receiverId) async {
    //get messages that send from firestore
    final CollectionReference collectionReference = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(senderId)
        .collection('message')
        .doc(receiverId)
        .collection('chats');
    // List<> data = [];
    print(collectionReference);
    final message = collectionReference
        .where('message')
        .orderBy('datatime', descending: true)
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        print(value.docs[i]['message']);
        // data.add(value.docs);
      }
      return value.docs;
    });
    print(message);
    return message;
  }
}
