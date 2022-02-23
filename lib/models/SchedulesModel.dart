/// status_code : "200"
/// message : "Success"
/// schedule_list : [{"id":"1","start_time":"16:28:00","end_time":"17:29:00","course_name":"group xy course","category_id":"1","subcategory_id":"1"}]

class SchedulesModel {
  SchedulesModel({
    String statusCode,
    String message,
    List<ScheduleList> scheduleList,
  }) {
    _statusCode = statusCode;
    _message = message;
    _scheduleList = scheduleList;
  }

  SchedulesModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['schedule_list'] != null) {
      _scheduleList = [];
      json['schedule_list'].forEach((v) {
        _scheduleList.add(ScheduleList.fromJson(v));
      });
    }
  }
  String _statusCode;
  String _message;
  List<ScheduleList> _scheduleList;

  String get statusCode => _statusCode;
  String get message => _message;
  List<ScheduleList> get scheduleList => _scheduleList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_scheduleList != null) {
      map['schedule_list'] = _scheduleList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// start_time : "16:28:00"
/// end_time : "17:29:00"
/// course_name : "group xy course"
/// category_id : "1"
/// subcategory_id : "1"

class ScheduleList {
  ScheduleList({
    String id,
    String startTime,
    String endTime,
    String courseName,
    String categoryId,
    String subcategoryId,
  }) {
    _id = id;
    _startTime = startTime;
    _endTime = endTime;
    _courseName = courseName;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
  }

  ScheduleList.fromJson(dynamic json) {
    _id = json['id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _courseName = json['course_name'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
  }
  String _id;
  String _startTime;
  String _endTime;
  String _courseName;
  String _categoryId;
  String _subcategoryId;

  String get id => _id;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get courseName => _courseName;
  String get categoryId => _categoryId;
  String get subcategoryId => _subcategoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['course_name'] = _courseName;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    return map;
  }
}
