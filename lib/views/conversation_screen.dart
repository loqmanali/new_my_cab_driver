import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_cab_driver/controllers/current_trip_provider.dart';
import 'package:my_cab_driver/controllers/firebase_helper/chat_methods.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/models/chat/conversation_model.dart';
import 'package:my_cab_driver/models/chat/message_model.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  final String _chatRoomId, _userName;

  ConversationScreen(this._chatRoomId, this._userName);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  UserDataProvider _userDataProvider;
  FireStoreHelper _fireStoreHelper = new FireStoreHelper();
  ConversationModel _conversationModel;
  final TextEditingController _editingController = new TextEditingController();
  String _currentMessage = "";
  Stream _messagesStream;
  CurrentTripProvider _tripProvider;

  bool _canSendMessage;

  Future _initialConversationModel() async {
    try {
      DocumentSnapshot documentSnapshot = await this
          ._fireStoreHelper
          .getConversationData(this.widget._chatRoomId);

      print(documentSnapshot.data);
      setState(() {
        this._conversationModel =
            new ConversationModel.fromDocumentSnapshot(documentSnapshot);
        this._canSendMessage = this._tripProvider.driverId ==
            this._conversationModel.chatUsersData.driverId;
      });
    } catch (e) {
      print("Exception in Init : $e");
    }
  }

  Future _sendMessage() async {
    if (this._currentMessage.length >= 1) {
      this
          ._fireStoreHelper
          .sendMessage(
              msg: "${this._currentMessage}",
              roomId: "${this.widget._chatRoomId}",
              sender: "${this._userDataProvider.name}")
          .then((value) => print("Done"));
      this._editingController.clear();
      this._currentMessage = "";
    }
  }

  Future _getMessages() async {
    this
        ._fireStoreHelper
        .getConversationMessages(roomId: "${this.widget._chatRoomId}")
        .then((value) => setState(() {
              this._messagesStream = value;
            }));
  }

  @override
  void initState() {
    this._initialConversationModel();
    this._getMessages();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of<UserDataProvider>(context);
    this._tripProvider = Provider.of<CurrentTripProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          "${this.widget._userName}",
        ),
      ),
      body: (this._conversationModel == null)
          ? Center(child: CircularProgressIndicator())
          : Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: this._messagesListWidget(),
                  ),
                  if (_canSendMessage == null)
                    SizedBox()
                  else if (this._canSendMessage)
                    this._sendTextField(context)
                  else
                    Container(
                      color: Colors.green,
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "لا يمكنك مراسلة هذا الشخص إلا أثناء وقت الرحلة",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _sendTextField(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        controller: this._editingController,
        maxLines: null,
        textInputAction: TextInputAction.newline,
        onChanged: (String value) => this._currentMessage = value,
        decoration: InputDecoration(
            hintText: "send Message",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              color: Colors.green,
              onPressed: () => _sendMessage(),
            ),
            fillColor: Colors.green.withOpacity(0.4),
            filled: true),
      ),
    );
  }

//  Widget _messagesListWidget() {
//    return StreamBuilder(
//      stream: this._messagesStream,
//      builder: (BuildContext context, snapshot) {
//        if (snapshot.data == null)
//          return Center(child: CircularProgressIndicator());
//        return ListView.builder(
//          itemCount: snapshot.data.documents.length,
//          itemBuilder: (BuildContext context, int index) {
//            return this._messageNodeWidget(
//              MessageModel.fromMap(
//                snapshot.data.documents[index].data(),
//                "pizza_dashboard",
//              ),
//            );
//          },
//        );
//      },
//    );
//  }
  Widget _messagesListWidget() {
    return StreamBuilder(
      stream: this._messagesStream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == null)
          return Center(child: CircularProgressIndicator());
        else
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
//            controller: this._scrollController,
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return this._messageNodeWidget(
                MessageModel.fromMap(
                  snapshot.data
                      .documents[snapshot.data.documents.length - index - 1]
                      .data(),
                  "${this._userDataProvider.name}",
                ),
              );
            },
          );
      },
    );
  }

  Widget _messageNodeWidget(MessageModel messageModel) {
    return Container(
      alignment:
          (messageModel.isMe) ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: (messageModel.isMe)
              ? Colors.green
              : Color(0xFF202020).withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topRight: (messageModel.isMe) ? Radius.circular(10.0) : Radius.zero,
            topLeft: (messageModel.isMe) ? Radius.zero : Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          ),
        ),
        child: Text(
          "${messageModel.msg}",
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }
}
