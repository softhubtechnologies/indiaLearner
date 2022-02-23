/// status_code : "200"
/// message : "Success"
/// downloads_list : [{"course_id":"22","category_id":"1","subcategory_id":"1","downloads_pdf":"https://indialearner.in/admin/uploads/English-SyllabusandModelQP1.pdf","title":"SYLLABUS ENGLISH"},{"course_id":"23","category_id":"1","subcategory_id":"1","downloads_pdf":"https://indialearner.in/admin/uploads/Maths_-_Syllabus_and_Model_QP1.pdf","title":"MATHEMATICS "},{"course_id":"24","category_id":"1","subcategory_id":"1","downloads_pdf":"https://indialearner.in/admin/uploads/Physics_-_Syllabus_and_Model_QP1.pdf","title":"PHYSICS"},{"course_id":"25","category_id":"1","subcategory_id":"1","downloads_pdf":"https://indialearner.in/admin/uploads/RAGA_-_Syllabus_and_Model_QP_(1)1.pdf","title":"RAGA"},{"course_id":"26","category_id":"1","subcategory_id":"1","downloads_pdf":"https://indialearner.in/admin/uploads/Maths_-_Syllabus_and_Model_QP2.pdf","title":"LATEST PDF"}]

class DownloadsModel {
  DownloadsModel({
    String statusCode,
    String message,
    List<Downloads_list> downloadsList,
  }) {
    _statusCode = statusCode;
    _message = message;
    _downloadsList = downloadsList;
  }

  DownloadsModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['downloads_list'] != null) {
      _downloadsList = [];
      json['downloads_list'].forEach((v) {
        _downloadsList.add(Downloads_list.fromJson(v));
      });
    }
  }
  String _statusCode;
  String _message;
  List<Downloads_list> _downloadsList;

  String get statusCode => _statusCode;
  String get message => _message;
  List<Downloads_list> get downloadsList => _downloadsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_downloadsList != null) {
      map['downloads_list'] = _downloadsList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// course_id : "22"
/// category_id : "1"
/// subcategory_id : "1"
/// downloads_pdf : "https://indialearner.in/admin/uploads/English-SyllabusandModelQP1.pdf"
/// title : "SYLLABUS ENGLISH"

class Downloads_list {
  Downloads_list({
    String courseId,
    String categoryId,
    String subcategoryId,
    String downloadsPdf,
    String title,
  }) {
    _courseId = courseId;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _downloadsPdf = downloadsPdf;
    _title = title;
  }

  Downloads_list.fromJson(dynamic json) {
    _courseId = json['course_id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _downloadsPdf = json['downloads_pdf'];
    _title = json['title'];
  }
  String _courseId;
  String _categoryId;
  String _subcategoryId;
  String _downloadsPdf;
  String _title;

  String get courseId => _courseId;
  String get categoryId => _categoryId;
  String get subcategoryId => _subcategoryId;
  String get downloadsPdf => _downloadsPdf;
  String get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['course_id'] = _courseId;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['downloads_pdf'] = _downloadsPdf;
    map['title'] = _title;
    return map;
  }
}
