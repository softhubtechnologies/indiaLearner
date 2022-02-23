/// status_code : "200"
/// exists : "0"
/// message : "Success"
/// test_details_list : [{"id":"19","test_id":"19","test_type":"1","test_date":"2022-01-12","category_id":"1","subcategory_id":"1","class_name":"","course_name":"27","mark":"1","test_time":"10","negative_mark":"1.00","test_item_details":[{"id":"42","question":"gfkjhvjklkjhgvcbnm","option1":"fghjhgfcvgh","option2":"dfghjjhgfdcv","option3":"sdfghjkl;sdfghjkl;","option4":"asdfghjkl;'","answer":"xcvbhnjkl;"},{"id":"43","question":"first","option1":"A","option2":"B","option3":"C","option4":"D","answer":"Ans"},{"id":"44","question":"Kushinagar is related to Buddha for which purpose","option1":"BIRTH","option2":"DEATH","option3":"FIRST SERMON","option4":"Enlightenment","answer":"DEATH"},{"id":"45","question":"Fundamental duties is given in which part of Constitution","option1":"2","option2":"3","option3":"4","option4":"4A","answer":"4A"},{"id":"46","question":"West flowing river of india ","option1":"Tapi","option2":"ganga","option3":"tungbadra","option4":"kaveri","answer":"Tapi"},{"id":"47","question":"Name of ocean between American continent and Europe","option1":"atlantic ocean","option2":"pecific ocean","option3":"indian ocean","option4":"arctic","answer":"atlantic ocean"},{"id":"48","question":"Beri beri disease is cause of which vitamin","option1":"A","option2":"B","option3":"C","option4":"D","answer":"B"},{"id":"49","question":"Longest river in India length wise","option1":"INDUS","option2":"GANGA","option3":"BRAHAMPUTRA","option4":"KAVERI","answer":"GANGA"},{"id":"50","question":"Who left india in last ","option1":"BRITISH","option2":"Portuguese","option3":"France","option4":"Dutch","answer":"Portuguese"},{"id":"51","question":"Name of CJ","option1":"NV Ramana","option2":"BOVDE","option3":"Vijay laxmi","option4":"AJIT DOVAL","answer":"NV RAMANA"},{"id":"52","question":"How many UTs in India at present","option1":"7","option2":"8","option3":"9","option4":"10","answer":"8"},{"id":"53","question":"Which continent is largest area wise.","option1":"ASIA","option2":"NORTH AMERICA","option3":"AUSTRELIA","option4":"EUROPE","answer":"ASIA"}]},{"id":"21","test_id":"21","test_type":"1","test_date":"2022-01-12","category_id":"1","subcategory_id":"1","class_name":"","course_name":"27","mark":"1","test_time":"10","negative_mark":"1.00","test_item_details":[{"id":"55","question":"Vaibhav","option1":"A","option2":"B","option3":"C","option4":"D","answer":"A"}]}]
/// test_result_list : null

class TestDetailsModel {
  TestDetailsModel({
    String statusCode,
    String exists,
    String message,
    List<TestDetailsList> testDetailsList,
    dynamic testResultList,
  }) {
    _statusCode = statusCode;
    _exists = exists;
    _message = message;
    _testDetailsList = testDetailsList;
    _testResultList = testResultList;
  }

  TestDetailsModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _exists = json['exists'];
    _message = json['message'];
    if (json['test_details_list'] != null) {
      _testDetailsList = [];
      json['test_details_list'].forEach((v) {
        _testDetailsList.add(TestDetailsList.fromJson(v));
      });
    }
    _testResultList = json['test_result_list'];
  }
  String _statusCode;
  String _exists;
  String _message;
  List<TestDetailsList> _testDetailsList;
  dynamic _testResultList;

  String get statusCode => _statusCode;
  String get exists => _exists;
  String get message => _message;
  List<TestDetailsList> get testDetailsList => _testDetailsList;
  dynamic get testResultList => _testResultList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['exists'] = _exists;
    map['message'] = _message;
    if (_testDetailsList != null) {
      map['test_details_list'] = _testDetailsList.map((v) => v.toJson()).toList();
    }
    map['test_result_list'] = _testResultList;
    return map;
  }
}

/// id : "19"
/// test_id : "19"
/// test_type : "1"
/// test_date : "2022-01-12"
/// category_id : "1"
/// subcategory_id : "1"
/// class_name : ""
/// course_name : "27"
/// mark : "1"
/// test_time : "10"
/// negative_mark : "1.00"
/// test_item_details : [{"id":"42","question":"gfkjhvjklkjhgvcbnm","option1":"fghjhgfcvgh","option2":"dfghjjhgfdcv","option3":"sdfghjkl;sdfghjkl;","option4":"asdfghjkl;'","answer":"xcvbhnjkl;"},{"id":"43","question":"first","option1":"A","option2":"B","option3":"C","option4":"D","answer":"Ans"},{"id":"44","question":"Kushinagar is related to Buddha for which purpose","option1":"BIRTH","option2":"DEATH","option3":"FIRST SERMON","option4":"Enlightenment","answer":"DEATH"},{"id":"45","question":"Fundamental duties is given in which part of Constitution","option1":"2","option2":"3","option3":"4","option4":"4A","answer":"4A"},{"id":"46","question":"West flowing river of india ","option1":"Tapi","option2":"ganga","option3":"tungbadra","option4":"kaveri","answer":"Tapi"},{"id":"47","question":"Name of ocean between American continent and Europe","option1":"atlantic ocean","option2":"pecific ocean","option3":"indian ocean","option4":"arctic","answer":"atlantic ocean"},{"id":"48","question":"Beri beri disease is cause of which vitamin","option1":"A","option2":"B","option3":"C","option4":"D","answer":"B"},{"id":"49","question":"Longest river in India length wise","option1":"INDUS","option2":"GANGA","option3":"BRAHAMPUTRA","option4":"KAVERI","answer":"GANGA"},{"id":"50","question":"Who left india in last ","option1":"BRITISH","option2":"Portuguese","option3":"France","option4":"Dutch","answer":"Portuguese"},{"id":"51","question":"Name of CJ","option1":"NV Ramana","option2":"BOVDE","option3":"Vijay laxmi","option4":"AJIT DOVAL","answer":"NV RAMANA"},{"id":"52","question":"How many UTs in India at present","option1":"7","option2":"8","option3":"9","option4":"10","answer":"8"},{"id":"53","question":"Which continent is largest area wise.","option1":"ASIA","option2":"NORTH AMERICA","option3":"AUSTRELIA","option4":"EUROPE","answer":"ASIA"}]

class TestDetailsList {
  TestDetailsList({
    String id,
    String testId,
    String testType,
    String testDate,
    String categoryId,
    String subcategoryId,
    String className,
    String courseName,
    String mark,
    String testTime,
    String negativeMark,
    List<TestItemDetails> testItemDetails,
  }) {
    _id = id;
    _testId = testId;
    _testType = testType;
    _testDate = testDate;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _className = className;
    _courseName = courseName;
    _mark = mark;
    _testTime = testTime;
    _negativeMark = negativeMark;
    _testItemDetails = testItemDetails;
  }

  TestDetailsList.fromJson(dynamic json) {
    _id = json['id'];
    _testId = json['test_id'];
    _testType = json['test_type'];
    _testDate = json['test_date'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _className = json['class_name'];
    _courseName = json['course_name'];
    _mark = json['mark'];
    _testTime = json['test_time'];
    _negativeMark = json['negative_mark'];
    if (json['test_item_details'] != null) {
      _testItemDetails = [];
      json['test_item_details'].forEach((v) {
        _testItemDetails.add(TestItemDetails.fromJson(v));
      });
    }
  }
  String _id;
  String _testId;
  String _testType;
  String _testDate;
  String _categoryId;
  String _subcategoryId;
  String _className;
  String _courseName;
  String _mark;
  String _testTime;
  String _negativeMark;
  List<TestItemDetails> _testItemDetails;

  String get id => _id;
  String get testId => _testId;
  String get testType => _testType;
  String get testDate => _testDate;
  String get categoryId => _categoryId;
  String get subcategoryId => _subcategoryId;
  String get className => _className;
  String get courseName => _courseName;
  String get mark => _mark;
  String get testTime => _testTime;
  String get negativeMark => _negativeMark;
  List<TestItemDetails> get testItemDetails => _testItemDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['test_id'] = _testId;
    map['test_type'] = _testType;
    map['test_date'] = _testDate;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['class_name'] = _className;
    map['course_name'] = _courseName;
    map['mark'] = _mark;
    map['test_time'] = _testTime;
    map['negative_mark'] = _negativeMark;
    if (_testItemDetails != null) {
      map['test_item_details'] = _testItemDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "42"
/// question : "gfkjhvjklkjhgvcbnm"
/// option1 : "fghjhgfcvgh"
/// option2 : "dfghjjhgfdcv"
/// option3 : "sdfghjkl;sdfghjkl;"
/// option4 : "asdfghjkl;'"
/// answer : "xcvbhnjkl;"

class TestItemDetails {
  TestItemDetails({
    String id,
    String question,
    String option1,
    String option2,
    String option3,
    String option4,
    String answer,
  }) {
    _id = id;
    _question = question;
    _option1 = option1;
    _option2 = option2;
    _option3 = option3;
    _option4 = option4;
    _answer = answer;
  }

  TestItemDetails.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _option1 = json['option1'];
    _option2 = json['option2'];
    _option3 = json['option3'];
    _option4 = json['option4'];
    _answer = json['answer'];
  }
  String _id;
  String _question;
  String _option1;
  String _option2;
  String _option3;
  String _option4;
  String _answer;

  String get id => _id;
  String get question => _question;
  String get option1 => _option1;
  String get option2 => _option2;
  String get option3 => _option3;
  String get option4 => _option4;
  String get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['option1'] = _option1;
    map['option2'] = _option2;
    map['option3'] = _option3;
    map['option4'] = _option4;
    map['answer'] = _answer;
    return map;
  }
}
