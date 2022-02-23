class BatchModel {
  List<BatchList> batchList;
  String statusCode;
  String message;

  BatchModel({this.batchList, this.statusCode, this.message});

  BatchModel.fromJson(Map<String, dynamic> json) {
    if (json['batch_list'] != null) {
      batchList = new List<BatchList>();
      json['batch_list'].forEach((v) {
        batchList.add(new BatchList.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.batchList != null) {
      data['batch_list'] = this.batchList.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class BatchList {
  String id;
  String courseId;
  String courseName;
  String batchName;
  String teacherId;

  BatchList({this.id, this.courseId, this.courseName, this.batchName, this.teacherId});

  BatchList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    batchName = json['batch_name'];
    teacherId = json['teacher_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['batch_name'] = this.batchName;
    data['teacher_id'] = this.teacherId;
    return data;
  }
}
