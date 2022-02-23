class ClassesSessionListModel {
  String statusCode;
  String message;
  List<VideoList> videoList;

  ClassesSessionListModel({this.statusCode, this.message, this.videoList});

  ClassesSessionListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['video_list'] != null) {
      videoList = new List<VideoList>();
      json['video_list'].forEach((v) {
        videoList.add(new VideoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.videoList != null) {
      data['video_list'] = this.videoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoList {
  String id;
  String categoryId;
  String subcategoryId;
  String courseName;
  String title;
  String video;
  String image;

  VideoList({this.id, this.categoryId, this.subcategoryId, this.courseName, this.title, this.video, this.image});

  VideoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    courseName = json['course_name'];
    title = json['title'];
    video = json['video'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['course_name'] = this.courseName;
    data['title'] = this.title;
    data['video'] = this.video;
    data['image'] = this.image;
    return data;
  }
}
