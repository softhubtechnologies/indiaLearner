/// status_code : "200"
/// message : "Success"
/// course_list : [{"course_id":"25","category_id":"1","subcategory_id":"1","course_name":"MATHEMATICS","file":"https://indialearner.in/admin/uploads/wp6738688-indian-air-force-desktop-wallpapers4.jpg","file2":null,"duration":"04 MONTHMATICS","course_fee":"3500","free_live_classes":"45","start_date":"2022-01-12","end_date":"2022-04-12","is_free":"1","is_purchase":0,"course_status":"Upcoming","plan_name":""},{"course_id":"26","category_id":"1","subcategory_id":"1","course_name":"PHYSICS","file":"https://indialearner.in/admin/uploads/wp6738688-indian-air-force-desktop-wallpapers3.jpg","file2":null,"duration":"04 MONTH","course_fee":"3500","free_live_classes":"45","start_date":"2022-01-12","end_date":"2022-04-12","is_free":"1","is_purchase":0,"course_status":"Upcoming","plan_name":""},{"course_id":"27","category_id":"1","subcategory_id":"1","course_name":"RAGA","file":"https://indialearner.in/admin/uploads/wp6738688-indian-air-force-desktop-wallpapers2.jpg","file2":null,"duration":"04 MONTH","course_fee":"3500","free_live_classes":"45","start_date":"2022-01-12","end_date":"2022-04-12","is_free":"1","is_purchase":0,"course_status":"Upcoming","plan_name":""},{"course_id":"28","category_id":"1","subcategory_id":"1","course_name":"ENGLISH","file":"https://indialearner.in/admin/uploads/wp6738688-indian-air-force-desktop-wallpapers1.jpg","file2":null,"duration":"04 MONTH","course_fee":"3500","free_live_classes":"45","start_date":"2022-01-12","end_date":"2022-04-12","is_free":"1","is_purchase":0,"course_status":"Upcoming","plan_name":""},{"course_id":"29","category_id":"1","subcategory_id":"1","course_name":"Defecnce Course Test","file":"https://indialearner.in/admin/uploads/Diwali_Offer_-_20211.jpg","file2":"https://indialearner.in/admin/uploads/INVOICE3.pdf","duration":"40","course_fee":"8000","free_live_classes":"5","start_date":"2021-12-01","end_date":"2022-01-10","is_free":"1","is_purchase":0,"course_status":"Complted","plan_name":""},{"course_id":"30","category_id":"1","subcategory_id":"1","course_name":"Defecnce Course Test Two","file":"https://indialearner.in/admin/uploads/WhatsApp_Image_2021-10-30_at_3_45_46_PM1.jpeg","file2":"https://indialearner.in/admin/uploads/INVOICE4.pdf","duration":"30","course_fee":"10000","free_live_classes":"10","start_date":"2022-01-13","end_date":"2022-02-13","is_free":"1","is_purchase":0,"course_status":"Upcoming","plan_name":""}]

class CourseListModel {
  CourseListModel({
    String statusCode,
    String message,
    List<CourseList> courseList,
  }) {
    _statusCode = statusCode;
    _message = message;
    _courseList = courseList;
  }

  CourseListModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['course_list'] != null) {
      _courseList = [];
      json['course_list'].forEach((v) {
        _courseList.add(CourseList.fromJson(v));
      });
    }
  }
  String _statusCode;
  String _message;
  List<CourseList> _courseList;

  String get statusCode => _statusCode;
  String get message => _message;
  List<CourseList> get courseList => _courseList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_courseList != null) {
      map['course_list'] = _courseList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// course_id : "25"
/// category_id : "1"
/// subcategory_id : "1"
/// course_name : "MATHEMATICS"
/// file : "https://indialearner.in/admin/uploads/wp6738688-indian-air-force-desktop-wallpapers4.jpg"
/// file2 : null
/// duration : "04 MONTHMATICS"
/// course_fee : "3500"
/// free_live_classes : "45"
/// start_date : "2022-01-12"
/// end_date : "2022-04-12"
/// is_free : "1"
/// is_purchase : 0
/// course_status : "Upcoming"
/// plan_name : ""

class CourseList {
  CourseList({
    String courseId,
    String categoryId,
    String subcategoryId,
    String courseName,
    String file,
    dynamic file2,
    String duration,
    String courseFee,
    String freeLiveClasses,
    String startDate,
    String endDate,
    String isFree,
    int isPurchase,
    String courseStatus,
    String planName,
  }) {
    _courseId = courseId;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _courseName = courseName;
    _file = file;
    _file2 = file2;
    _duration = duration;
    _courseFee = courseFee;
    _freeLiveClasses = freeLiveClasses;
    _startDate = startDate;
    _endDate = endDate;
    _isFree = isFree;
    _isPurchase = isPurchase;
    _courseStatus = courseStatus;
    _planName = planName;
  }

  CourseList.fromJson(dynamic json) {
    _courseId = json['course_id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _courseName = json['course_name'];
    _file = json['file'];
    _file2 = json['file2'];
    _duration = json['duration'];
    _courseFee = json['course_fee'];
    _freeLiveClasses = json['free_live_classes'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _isFree = json['is_free'];
    _isPurchase = json['is_purchase'];
    _courseStatus = json['course_status'];
    _planName = json['plan_name'];
  }
  String _courseId;
  String _categoryId;
  String _subcategoryId;
  String _courseName;
  String _file;
  dynamic _file2;
  String _duration;
  String _courseFee;
  String _freeLiveClasses;
  String _startDate;
  String _endDate;
  String _isFree;
  int _isPurchase;
  String _courseStatus;
  String _planName;

  String get courseId => _courseId;
  String get categoryId => _categoryId;
  String get subcategoryId => _subcategoryId;
  String get courseName => _courseName;
  String get file => _file;
  dynamic get file2 => _file2;
  String get duration => _duration;
  String get courseFee => _courseFee;
  String get freeLiveClasses => _freeLiveClasses;
  String get startDate => _startDate;
  String get endDate => _endDate;
  String get isFree => _isFree;
  int get isPurchase => _isPurchase;
  String get courseStatus => _courseStatus;
  String get planName => _planName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['course_id'] = _courseId;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['course_name'] = _courseName;
    map['file'] = _file;
    map['file2'] = _file2;
    map['duration'] = _duration;
    map['course_fee'] = _courseFee;
    map['free_live_classes'] = _freeLiveClasses;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['is_free'] = _isFree;
    map['is_purchase'] = _isPurchase;
    map['course_status'] = _courseStatus;
    map['plan_name'] = _planName;
    return map;
  }
}
