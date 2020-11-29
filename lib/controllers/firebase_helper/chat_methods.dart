import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreHelper {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<bool> addChatRoom(
      {@required String roomId, @required Map<String, dynamic> data}) async {
    try {
      await this._fireStore.collection("chats").doc("$roomId").set(data);
      return true;
    } catch (e) {
      print("Exception : $e");
      return false;
    }
  }

  Future<DocumentSnapshot> getConversationData(String chatRoomId) async =>
      await this._fireStore.collection("chats").doc("$chatRoomId").get();

  Future sendMessage(
      {@required String roomId, @required String msg, String sender}) async {
    await this
        ._fireStore
        .collection("chats")
        .doc("$roomId")
        .collection("messages")
        .add({"send_by": "$sender", "message": "$msg", "date": DateTime.now()});
  }

  Future<Stream<QuerySnapshot>> getConversationMessages(
      {@required String roomId}) async {
    return this
        ._fireStore
        .collection("chats")
        .doc("$roomId")
        .collection("messages")
        .orderBy("date")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getMyChats(String myName) async {
    return this
        ._fireStore
        .collection("chats")
        .where("users", arrayContains: "$myName")
        .snapshots();
  }

  Future<QuerySnapshot> getUserByUserName(String userName) async =>
      await _getUser(searchKey: "user_name", isEqualTo: "$userName");

  Future<QuerySnapshot> getUserByEmail(String email) async =>
      await _getUser(searchKey: "email", isEqualTo: "$email");

  //helper method
  Future<QuerySnapshot> _getUser(
      {@required String searchKey, @required String isEqualTo}) async {
    return await this
        ._fireStore
        .collection("users")
        .where("$searchKey", isEqualTo: "$isEqualTo")
        .get();
  }

  String getRoomId({@required String userId, @required String driverId}) =>
      'user_${userId}_driver_$driverId';
}
