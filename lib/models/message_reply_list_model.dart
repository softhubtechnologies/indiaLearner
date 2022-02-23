/// status_code : "200"
/// message : "Success"
/// message_list : [{"id":"20","user_id":"8","first_name":"vaibhav","last_name":"mali","message":"Hello teacher test","date":"2022-01-11","time":"10:17:59am","reply_list":[{"id":"4","message_id":"20","teacher_id":"1","name":"Lukman Test","reply":"accc","date":"2022-01-11","time":"04:01:25pm"}]},{"id":"23","user_id":"8","first_name":"vaibhav","last_name":"mali","message":"Hello teacher test","date":"2022-01-11","time":"10:43:31am","reply_list":null},{"id":"24","user_id":"8","first_name":"vaibhav","last_name":"mali","message":"Hello teacher test","date":"2022-01-11","time":"10:44:17am","reply_list":null}]

class MessageReplyListModel {
  MessageReplyListModel({
    String statusCode,
    String message,
    List<Message_list> messageList,
  }) {
    _statusCode = statusCode;
    _message = message;
    _messageList = messageList;
  }

  MessageReplyListModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['message_list'] != null) {
      _messageList = [];
      json['message_list'].forEach((v) {
        _messageList.add(Message_list.fromJson(v));
      });
    }
  }
  String _statusCode;
  String _message;
  List<Message_list> _messageList;

  String get statusCode => _statusCode;
  String get message => _message;
  List<Message_list> get messageList => _messageList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_messageList != null) {
      map['message_list'] = _messageList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "20"
/// user_id : "8"
/// first_name : "vaibhav"
/// last_name : "mali"
/// message : "Hello teacher test"
/// date : "2022-01-11"
/// time : "10:17:59am"
/// reply_list : [{"id":"4","message_id":"20","teacher_id":"1","name":"Lukman Test","reply":"accc","date":"2022-01-11","time":"04:01:25pm"}]

class Message_list {
  Message_list({
    String id,
    String userId,
    String firstName,
    String lastName,
    String message,
    String date,
    String time,
    List<Reply_list> replyList,
  }) {
    _id = id;
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _message = message;
    _date = date;
    _time = time;
    _replyList = replyList;
  }

  Message_list.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _message = json['message'];
    _date = json['date'];
    _time = json['time'];
    if (json['reply_list'] != null) {
      _replyList = [];
      json['reply_list'].forEach((v) {
        _replyList.add(Reply_list.fromJson(v));
      });
    }
  }
  String _id;
  String _userId;
  String _firstName;
  String _lastName;
  String _message;
  String _date;
  String _time;
  List<Reply_list> _replyList;

  String get id => _id;
  String get userId => _userId;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get message => _message;
  String get date => _date;
  String get time => _time;
  List<Reply_list> get replyList => _replyList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['message'] = _message;
    map['date'] = _date;
    map['time'] = _time;
    map['reply_list'] = _replyList.map((v) => v.toJson()).toList();

    return map;
  }
}

/// id : "4"
/// message_id : "20"
/// teacher_id : "1"
/// name : "Lukman Test"
/// reply : "accc"
/// date : "2022-01-11"
/// time : "04:01:25pm"

class Reply_list {
  Reply_list({
    String id,
    String messageId,
    String teacherId,
    String name,
    String reply,
    String date,
    String time,
  }) {
    _id = id;
    _messageId = messageId;
    _teacherId = teacherId;
    _name = name;
    _reply = reply;
    _date = date;
    _time = time;
  }

  Reply_list.fromJson(dynamic json) {
    _id = json['id'];
    _messageId = json['message_id'];
    _teacherId = json['teacher_id'];
    _name = json['name'];
    _reply = json['reply'];
    _date = json['date'];
    _time = json['time'];
  }
  String _id;
  String _messageId;
  String _teacherId;
  String _name;
  String _reply;
  String _date;
  String _time;

  String get id => _id;
  String get messageId => _messageId;
  String get teacherId => _teacherId;
  String get name => _name;
  String get reply => _reply;
  String get date => _date;
  String get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['message_id'] = _messageId;
    map['teacher_id'] = _teacherId;
    map['name'] = _name;
    map['reply'] = _reply;
    map['date'] = _date;
    map['time'] = _time;
    return map;
  }
}
