import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:womensaftey/Pages/singleMessageScreen.dart';
import 'package:womensaftey/controller/firebase_controller.dart';
import 'package:womensaftey/models/user_model/user_model.dart';

class Message extends StatelessWidget {
  Message({super.key, required this.type});
  final String type;
  FirebaseController controller = Get.put(FirebaseController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        //controller.getUsersGuadientList();
      },
    );
    final user = (type == "child")
        ? controller.getUsersGuadientList()
        : controller.getchildsforGardian();
    print("111111111111111user$user");
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CupertinoSearchTextField(),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  // final data = snapshot.data!.docs[index];
                  final data = controller.listofguardians;
                  final individualData = data[0];
                  // final dataDecorded = jsonDecode(data[0].toString());
                  // final user = UserModel.fromJson(dataDecorded);
                  // print(user.username);
                  return InkWell(
                    onTap: () {
                      Get.to(() => SingleMessageScreen(
                            gardianName: data[index]['username'],
                            guardianId: data[index]['id'],
                          ));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.red[index % 10 * 100],
                        child: Text("${data[index]['username'][0]}"),
                      ),
                      title: Text(data[index]['username']),
                      subtitle: const Text("message"),
                      trailing: Badge(
                        badgeContent: Text("1"),
                        badgeStyle: BadgeStyle(
                            borderRadius: BorderRadius.circular(15),
                            badgeColor: Colors.blue),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 20,

                    //color: Colors.grey,
                    child: Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 70,
                          ),
                          Container(
                            width: 300,
                            height: MediaQuery.of(context).size.height * 0.002,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: controller.listofguardians.length,
              ),
            )),
          ],
        ),
      )),
    );
  }
}

// import 'package:badges/badges.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:womensaftey/Pages/singleMessageScreen.dart';
// import 'package:womensaftey/controller/firebase_controller.dart';

// class Message extends StatelessWidget {
//   Message({super.key});
//   FirebaseController controller = Get.put(FirebaseController());
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (timeStamp) {
//         controller.getUsersGuadientList();
//       },
//     );
//     final user = controller.getUsersGuadientList();
//     print(user);
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             CupertinoSearchTextField(),
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection('users')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     return snapshot.hasData
//                         ? ListView.separated(
//                             shrinkWrap: true,
//                             physics: ScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               final data = snapshot.data!.docs[index];

//                               return InkWell(
//                                 onTap: () {
//                                   Get.to(() => const SingleMessageScreen());
//                                 },
//                                 child: ListTile(
//                                   leading: CircleAvatar(
//                                     radius: 30,
//                                     backgroundColor:
//                                         Colors.red[index % 10 * 100],
//                                   ),
//                                   title: Text(data['username']),
//                                   subtitle: Text("message"),
//                                   trailing: Badge(
//                                     badgeContent: Text("1"),
//                                     badgeStyle: BadgeStyle(
//                                         borderRadius: BorderRadius.circular(15),
//                                         badgeColor: Colors.blue),
//                                   ),
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (context, index) {
//                               return Container(
//                                 height: 20,

//                                 //color: Colors.grey,
//                                 child: Positioned(
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: 70,
//                                       ),
//                                       Container(
//                                         width: 300,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.002,
//                                         color: Colors.grey,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                             itemCount: snapshot.data!.docs.length,
//                           )
//                         : Center(
//                             child: CircularProgressIndicator(),
//                           );
//                   }),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
