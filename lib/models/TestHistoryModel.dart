/// status_code : "200"
/// message : "Success"
/// test_result_list : [{"id":"1","category_id":"1","subcategory_id":"1","user_id":"4","test_id":"13","test_type":"3","subtest":"1","obtain_marks":"50","total_marks":"70","test_name":"Free Test Subtest","answer_sheet":"https://indialearner.in/admin/uploads/INVOICE5.pdf","checked_answer_sheet":"https://indialearner.in/admin/uploads/INVOICE5.pdf"}]

class TestHistoryModel {
  TestHistoryModel({
    String statusCode,
    String message,
    List<Test_result_list> testResultList,
  }) {
    _statusCode = statusCode;
    _message = message;
    _testResultList = testResultList;
  }

  TestHistoryModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['test_result_list'] != null) {
      _testResultList = [];
      json['test_result_list'].forEach((v) {
        _testResultList.add(Test_result_list.fromJson(v));
      });
    }
  }
  String _statusCode;
  String _message;
  List<Test_result_list> _testResultList;

  String get statusCode => _statusCode;
  String get message => _message;
  List<Test_result_list> get testResultList => _testResultList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_testResultList != null) {
      map['test_result_list'] = _testResultList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// category_id : "1"
/// subcategory_id : "1"
/// user_id : "4"
/// test_id : "13"
/// test_type : "3"
/// subtest : "1"
/// obtain_marks : "50"
/// total_marks : "70"
/// test_name : "Free Test Subtest"
/// answer_sheet : "https://indialearner.in/admin/uploads/INVOICE5.pdf"
/// checked_answer_sheet : "https://indialearner.in/admin/uploads/INVOICE5.pdf"

class Test_result_list {
  Test_result_list({
    String id,
    String categoryId,
    String subcategoryId,
    String userId,
    String testId,
    String testType,
    String subtest,
    String obtainMarks,
    String totalMarks,
    String testName,
    String answerSheet,
    String checkedAnswerSheet,
  }) {
    _id = id;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _userId = userId;
    _testId = testId;
    _testType = testType;
    _subtest = subtest;
    _obtainMarks = obtainMarks;
    _totalMarks = totalMarks;
    _testName = testName;
    _answerSheet = answerSheet;
    _checkedAnswerSheet = checkedAnswerSheet;
  }

  Test_result_list.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _userId = json['user_id'];
    _testId = json['test_id'];
    _testType = json['test_type'];
    _subtest = json['subtest'];
    _obtainMarks = json['obtain_marks'];
    _totalMarks = json['total_marks'];
    _testName = json['test_name'];
    _answerSheet = json['answer_sheet'];
    _checkedAnswerSheet = json['checked_answer_sheet'];
  }
  String _id;
  String _categoryId;
  String _subcategoryId;
  String _userId;
  String _testId;
  String _testType;
  String _subtest;
  String _obtainMarks;
  String _totalMarks;
  String _testName;
  String _answerSheet;
  String _checkedAnswerSheet;

  String get id => _id;
  String get categoryId => _categoryId;
  String get subcategoryId => _subcategoryId;
  String get userId => _userId;
  String get testId => _testId;
  String get testType => _testType;
  String get subtest => _subtest;
  String get obtainMarks => _obtainMarks;
  String get totalMarks => _totalMarks;
  String get testName => _testName;
  String get answerSheet => _answerSheet;
  String get checkedAnswerSheet => _checkedAnswerSheet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['user_id'] = _userId;
    map['test_id'] = _testId;
    map['test_type'] = _testType;
    map['subtest'] = _subtest;
    map['obtain_marks'] = _obtainMarks;
    map['total_marks'] = _totalMarks;
    map['test_name'] = _testName;
    map['answer_sheet'] = _answerSheet;
    map['checked_answer_sheet'] = _checkedAnswerSheet;
    return map;
  }
}
