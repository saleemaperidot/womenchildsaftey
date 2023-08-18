import 'package:get/get.dart';
import 'package:womensaftey/services/chatServises.dart';

class MessageController extends GetxController {
  RxList<dynamic> messageList = [].obs;

  void getAllMessages(String senderId, String receiverId) async {
    messageList.clear();
    List<dynamic> mesagelistfromservice = await ChatWithGardianServises()
        .geMessagesFromFirestore(senderId, receiverId);

    messageList.addAll(mesagelistfromservice);
    print("_==$mesagelistfromservice");
  }
}
