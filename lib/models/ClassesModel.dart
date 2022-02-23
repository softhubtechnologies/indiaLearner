class ClassesModel {
  String statusCode;
  String message;
  List<ClassList> classList;

  ClassesModel({this.statusCode, this.message, this.classList});

  ClassesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['class_list'] != null) {
      classList = new List<ClassList>();
      json['class_list'].forEach((v) {
        classList.add(new ClassList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.classList != null) {
      data['class_list'] = this.classList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassList {
  String courseId;
  String categoryId;
  String subcategoryId;
  String className;

  ClassList({this.courseId, this.categoryId, this.subcategoryId, this.className});

  ClassList.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['class_name'] = this.className;
    return data;
  }
}
