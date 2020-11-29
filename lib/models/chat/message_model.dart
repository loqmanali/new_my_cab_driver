class MessageModel {
  String _msg;

  bool _isMe;

  MessageModel.fromMap(Map<String, dynamic> data, String myName) {
    this._msg = data['message'];
    this._isMe = (data['send_by'] == myName) ? true : false;
  }

  String get msg => this._msg;

  bool get isMe => this._isMe;
}
