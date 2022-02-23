class TeacherListModel {
  String statusCode;
  String message;
  List<TeacherList> teacherList;

  TeacherListModel({this.statusCode, this.message, this.teacherList});

  TeacherListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['teacher_list'] != null) {
      teacherList = new List<TeacherList>();
      json['teacher_list'].forEach((v) {
        teacherList.add(new TeacherList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.teacherList != null) {
      data['teacher_list'] = this.teacherList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherList {
  String id;
  String name;
  String mobile;
  String email;
  String address;
  String city;
  String file;
  String bio;
  List<String> course;

  TeacherList({this.bio, this.id, this.name, this.mobile, this.email, this.address, this.city, this.file, this.course});

  TeacherList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bio = json['bio'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    file = json['file'];
    course = json['course'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bio'] = this.bio;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['file'] = this.file;
    data['course'] = this.course;
    return data;
  }
}
