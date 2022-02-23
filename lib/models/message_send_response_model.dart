/// Status_code : "200"
/// result : {"id":"3","user_id":"8","message":"Hello teacher test","time":"04:36:21am","date":"2021-10-28"}

class MessageSendResponseModel {
  MessageSendResponseModel({
    String statusCode,
    Result result,
  }) {
    _statusCode = statusCode;
    _result = result;
  }

  MessageSendResponseModel.fromJson(dynamic json) {
    _statusCode = json['Status_code'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String _statusCode;
  Result _result;

  String get statusCode => _statusCode;
  Result get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status_code'] = _statusCode;
    if (_result != null) {
      map['result'] = _result.toJson();
    }
    return map;
  }
}

/// id : "3"
/// user_id : "8"
/// message : "Hello teacher test"
/// time : "04:36:21am"
/// date : "2021-10-28"

class Result {
  Result({
    String id,
    String userId,
    String message,
    String time,
    String date,
  }) {
    _id = id;
    _userId = userId;
    _message = message;
    _time = time;
    _date = date;
  }

  Result.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _message = json['message'];
    _time = json['time'];
    _date = json['date'];
  }
  String _id;
  String _userId;
  String _message;
  String _time;
  String _date;

  String get id => _id;
  String get userId => _userId;
  String get message => _message;
  String get time => _time;
  String get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['message'] = _message;
    map['time'] = _time;
    map['date'] = _date;
    return map;
  }
}
