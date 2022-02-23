class PlusSessionModel {
  String statusCode;
  String message;
  List<PlusSessionLiveList> plusSessionLiveList;

  PlusSessionModel({this.statusCode, this.message, this.plusSessionLiveList});

  PlusSessionModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['plus_session_live_list'] != null) {
      plusSessionLiveList = new List<PlusSessionLiveList>();
      json['plus_session_live_list'].forEach((v) {
        plusSessionLiveList.add(new PlusSessionLiveList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.plusSessionLiveList != null) {
      data['plus_session_live_list'] = this.plusSessionLiveList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlusSessionLiveList {
  String id;
  String link;
  String type;
  String session;
  String courseId;
  String batchId;
  String startTime;
  String endTime;
  String title;
  String date;
  String categoryId;
  String subcategoryId;
  String courseName;
  String image;

  PlusSessionLiveList({this.id, this.link, this.type, this.session, this.courseId, this.batchId, this.startTime, this.endTime, this.title, this.date, this.categoryId, this.subcategoryId, this.courseName, this.image});

  PlusSessionLiveList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    type = json['type'];
    session = json['session'];
    courseId = json['course_id'];
    batchId = json['batch_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    title = json['title'];
    date = json['date'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    courseName = json['course_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['type'] = this.type;
    data['session'] = this.session;
    data['course_id'] = this.courseId;
    data['batch_id'] = this.batchId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['title'] = this.title;
    data['date'] = this.date;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['course_name'] = this.courseName;
    data['image'] = this.image;
    return data;
  }
}
