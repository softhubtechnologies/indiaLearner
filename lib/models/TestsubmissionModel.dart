class TestsubmissionModel {
  String statusCode;
  Result result;

  TestsubmissionModel({this.statusCode, this.result});

  TestsubmissionModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['Status_code'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status_code'] = this.statusCode;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String id;
  String categoryId;
  String subcategoryId;
  String userId;
  String testId;
  String testType;
  String answerSheet;
  String obtainMarks;
  String totalMarks;

  Result({this.id, this.categoryId, this.subcategoryId, this.userId, this.testId, this.testType, this.answerSheet, this.obtainMarks, this.totalMarks});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    userId = json['user_id'];
    testId = json['test_id'];
    testType = json['test_type'];
    answerSheet = json['answer_sheet'];
    obtainMarks = json['obtain_marks'];
    totalMarks = json['total_marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['user_id'] = this.userId;
    data['test_id'] = this.testId;
    data['test_type'] = this.testType;
    data['answer_sheet'] = this.answerSheet;
    data['obtain_marks'] = this.obtainMarks;
    data['total_marks'] = this.totalMarks;
    return data;
  }
}
