class TopVideosModel {
  String statusCode;
  String message;
  List<TopVideosList> topVideosList;

  TopVideosModel({this.statusCode, this.message, this.topVideosList});

  TopVideosModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['top_videos_list'] != null) {
      topVideosList = new List<TopVideosList>();
      json['top_videos_list'].forEach((v) {
        topVideosList.add(new TopVideosList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.topVideosList != null) {
      data['top_videos_list'] =
          this.topVideosList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopVideosList {
  String courseId;
  String categoryId;
  String subcategoryId;
  String courseName;
  String title;
  String video;
  String image;
  String preference;

  TopVideosList(
      {this.courseId,
        this.categoryId,
        this.subcategoryId,
        this.courseName,
        this.title,
        this.video,
        this.image,
        this.preference});

  TopVideosList.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    courseName = json['course_name'];
    title = json['title'];
    video = json['video'];
    image = json['image'];
    preference = json['preference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['course_name'] = this.courseName;
    data['title'] = this.title;
    data['video'] = this.video;
    data['image'] = this.image;
    data['preference'] = this.preference;
    return data;
  }
}
