/// live_list : [{"id":"8","zoom_id":"https://meet.google.com/eiy-qyeg-dzt","session":"New Live","course_id":"32","batch_id":"1","start_time":"11:12:00","end_time":"12:12:00","title":"Todays Live Class","date":"2022-01-12","is_free":"0","is_purchase":1},{"id":"7","zoom_id":"https://us04web.zoom.us/j/7482470647?pwd=ZGZnNGM3eVdFWUNNNldZTmJybkdaQT09","session":"Zoom live","course_id":"34","batch_id":"11","start_time":"08:55:00","end_time":"11:00:00","title":"Uju","date":"2022-01-10","is_free":"2","is_purchase":1},{"id":"9","zoom_id":"https://meet.google.com/eiy-qyeg-dzt","session":"mock99","course_id":"38","batch_id":"11","start_time":"15:20:00","end_time":"16:30:00","title":"live mock 99","date":"2022-01-12","is_free":"1","is_purchase":1}]
/// status_code : "200"
/// message : "Success"

class LiveSessionListModel {
  LiveSessionListModel({
    List<LiveList> liveList,
    String statusCode,
    String message,
  }) {
    _liveList = liveList;
    _statusCode = statusCode;
    _message = message;
  }

  LiveSessionListModel.fromJson(dynamic json) {
    if (json['live_list'] != null) {
      _liveList = [];
      json['live_list'].forEach((v) {
        _liveList.add(LiveList.fromJson(v));
      });
    }
    _statusCode = json['status_code'];
    _message = json['message'];
  }
  List<LiveList> _liveList;
  String _statusCode;
  String _message;

  List<LiveList> get liveList => _liveList;
  String get statusCode => _statusCode;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_liveList != null) {
      map['live_list'] = _liveList.map((v) => v.toJson()).toList();
    }
    map['status_code'] = _statusCode;
    map['message'] = _message;
    return map;
  }
}

/// id : "8"
/// zoom_id : "https://meet.google.com/eiy-qyeg-dzt"
/// session : "New Live"
/// course_id : "32"
/// batch_id : "1"
/// start_time : "11:12:00"
/// end_time : "12:12:00"
/// title : "Todays Live Class"
/// date : "2022-01-12"
/// is_free : "0"
/// is_purchase : 1

class LiveList {
  LiveList({
    String id,
    String zoomId,
    String session,
    String courseId,
    String batchId,
    String startTime,
    String endTime,
    String title,
    String date,
    String isFree,
    int isPurchase,
  }) {
    _id = id;
    _zoomId = zoomId;
    _session = session;
    _courseId = courseId;
    _batchId = batchId;
    _startTime = startTime;
    _endTime = endTime;
    _title = title;
    _date = date;
    _isFree = isFree;
    _isPurchase = isPurchase;
  }

  LiveList.fromJson(dynamic json) {
    _id = json['id'];
    _zoomId = json['zoom_id'];
    _session = json['session'];
    _courseId = json['course_id'];
    _batchId = json['batch_id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _title = json['title'];
    _date = json['date'];
    _isFree = json['is_free'];
    _isPurchase = json['is_purchase'];
  }
  String _id;
  String _zoomId;
  String _session;
  String _courseId;
  String _batchId;
  String _startTime;
  String _endTime;
  String _title;
  String _date;
  String _isFree;
  int _isPurchase;

  String get id => _id;
  String get zoomId => _zoomId;
  String get session => _session;
  String get courseId => _courseId;
  String get batchId => _batchId;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get title => _title;
  String get date => _date;
  String get isFree => _isFree;
  int get isPurchase => _isPurchase;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['zoom_id'] = _zoomId;
    map['session'] = _session;
    map['course_id'] = _courseId;
    map['batch_id'] = _batchId;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['title'] = _title;
    map['date'] = _date;
    map['is_free'] = _isFree;
    map['is_purchase'] = _isPurchase;
    return map;
  }
}
