class TestTypeModel {
  String statusCode;
  String message;
  List<TestTypeList> testTypeList;

  TestTypeModel({this.statusCode, this.message, this.testTypeList});

  TestTypeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['test_type_list'] != null) {
      testTypeList = new List<TestTypeList>();
      json['test_type_list'].forEach((v) {
        testTypeList.add(new TestTypeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.testTypeList != null) {
      data['test_type_list'] = this.testTypeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestTypeList {
  String id;
  String testType;

  TestTypeList({this.id, this.testType});

  TestTypeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testType = json['test_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_type'] = this.testType;
    return data;
  }
}
