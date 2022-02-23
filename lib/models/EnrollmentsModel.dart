/// status_code : "200"
/// message : "Success"
/// enrollments_list : [{"id":"3","category_id":"1","subcategory_id":"1","user_id":"4","plan_name":"1Month","class_name":"Test","course_name":"ttt","start_date":"hhh","end_date":"ggg"}]

class EnrollmentsModel {
  EnrollmentsModel({
    String statusCode,
    String message,
    List<EnrollmentsList> enrollmentsList,
  }) {
    _statusCode = statusCode;
    _message = message;
    _enrollmentsList = enrollmentsList;
  }

  EnrollmentsModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['enrollments_list'] != null) {
      _enrollmentsList = [];
      json['enrollments_list'].forEach((v) {
        _enrollmentsList.add(EnrollmentsList.fromJson(v));
      });
    }
  }
  String _statusCode;
  String _message;
  List<EnrollmentsList> _enrollmentsList;

  String get statusCode => _statusCode;
  String get message => _message;
  List<EnrollmentsList> get enrollmentsList => _enrollmentsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_enrollmentsList != null) {
      map['enrollments_list'] = _enrollmentsList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "3"
/// category_id : "1"
/// subcategory_id : "1"
/// user_id : "4"
/// plan_name : "1Month"
/// class_name : "Test"
/// course_name : "ttt"
/// start_date : "hhh"
/// end_date : "ggg"

class EnrollmentsList {
  EnrollmentsList({
    String id,
    String categoryId,
    String subcategoryId,
    String userId,
    String planName,
    String className,
    String courseName,
    String startDate,
    String endDate,
  }) {
    _id = id;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _userId = userId;
    _planName = planName;
    _className = className;
    _courseName = courseName;
    _startDate = startDate;
    _endDate = endDate;
  }

  EnrollmentsList.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _userId = json['user_id'];
    _planName = json['plan_name'];
    _className = json['class_name'];
    _courseName = json['course_name'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
  }
  String _id;
  String _categoryId;
  String _subcategoryId;
  String _userId;
  String _planName;
  String _className;
  String _courseName;
  String _startDate;
  String _endDate;

  String get id => _id;
  String get categoryId => _categoryId;
  String get subcategoryId => _subcategoryId;
  String get userId => _userId;
  String get planName => _planName;
  String get className => _className;
  String get courseName => _courseName;
  String get startDate => _startDate;
  String get endDate => _endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['user_id'] = _userId;
    map['plan_name'] = _planName;
    map['class_name'] = _className;
    map['course_name'] = _courseName;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    return map;
  }
}
