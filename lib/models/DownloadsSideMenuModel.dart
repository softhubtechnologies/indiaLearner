class DownloadsSideMenuModel {
  String statusCode;
  String message;
  List<DownloadsList> downloadsList;

  DownloadsSideMenuModel({this.statusCode, this.message, this.downloadsList});

  DownloadsSideMenuModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['downloads_list'] != null) {
      downloadsList = new List<DownloadsList>();
      json['downloads_list'].forEach((v) {
        downloadsList.add(new DownloadsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.downloadsList != null) {
      data['downloads_list'] =
          this.downloadsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DownloadsList {
  String courseId;
  String categoryId;
  String subcategoryId;
  String downloadsPdf;
  String title;

  DownloadsList(
      {this.courseId,
        this.categoryId,
        this.subcategoryId,
        this.downloadsPdf,
        this.title});

  DownloadsList.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    downloadsPdf = json['downloads_pdf'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['downloads_pdf'] = this.downloadsPdf;
    data['title'] = this.title;
    return data;
  }
}
