class PlusCourseModel {
  String statusCode;
  String message;
  List<PlusCourseList> plusCourseList;

  PlusCourseModel({this.statusCode, this.message, this.plusCourseList});

  PlusCourseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['plus_course_list'] != null) {
      plusCourseList = new List<PlusCourseList>();
      json['plus_course_list'].forEach((v) {
        plusCourseList.add(new PlusCourseList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.plusCourseList != null) {
      data['plus_course_list'] =
          this.plusCourseList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlusCourseList {
  String id;
  String categoryId;
  String subcategoryId;
  String price;
  String courseName;
  String duration;
  String fileUp;
  String date;

  PlusCourseList(
      {this.id,
        this.categoryId,
        this.subcategoryId,
        this.price,
        this.courseName,
        this.duration,
        this.fileUp,
        this.date});

  PlusCourseList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    price = json['price'];
    courseName = json['course_name'];
    duration = json['duration'];
    fileUp = json['file_up'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['price'] = this.price;
    data['course_name'] = this.courseName;
    data['duration'] = this.duration;
    data['file_up'] = this.fileUp;
    data['date'] = this.date;
    return data;
  }
}
