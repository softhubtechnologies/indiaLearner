/// status_code : "200"
/// message : "Success"
/// subtest_details_list : [{"id":"1","test_type_id":"1","subtest":"Free Test Subtest","syllabus":null,"zoom_link":null,"syllabus_pdf":null,"quation_paper_pdf":"https://indialearner.in/admin/uploads/sudhir.pdf","answer_format_pdf":"https://indialearner.in/admin/uploads/sudhir1.pdf"},{"id":"7","test_type_id":"1","subtest":"gs all","syllabus":"","zoom_link":"1001","syllabus_pdf":"","quation_paper_pdf":"https://indialearner.in/admin/uploads/sudhir.pdf","answer_format_pdf":"https://indialearner.in/admin/uploads/sudhir1.pdf"},{"id":"14","test_type_id":"1","subtest":"test new","syllabus":null,"zoom_link":"link new","syllabus_pdf":"","quation_paper_pdf":"https://indialearner.in/admin/uploads/sudhir.pdf","answer_format_pdf":"https://indialearner.in/admin/uploads/sudhir1.pdf"},{"id":"16","test_type_id":"1","subtest":"RAGA-GK","syllabus":null,"zoom_link":"ZOOM","syllabus_pdf":"https://indialearner.in/admin/uploads/RAGA_-_Syllabus_and_Model_QP_(1)2.pdf","quation_paper_pdf":"https://indialearner.in/admin/uploads/sudhir.pdf","answer_format_pdf":"https://indialearner.in/admin/uploads/sudhir1.pdf"}]

class SubtestModel {
  SubtestModel({
    String statusCode,
    String message,
    List<SubtestDetailsList> subtestDetailsList,
  }) {
    _statusCode = statusCode;
    _message = message;
    _subtestDetailsList = subtestDetailsList;
  }

  SubtestModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['subtest_details_list'] != null) {
      _subtestDetailsList = [];
      json['subtest_details_list'].forEach((v) {
        _subtestDetailsList.add(SubtestDetailsList.fromJson(v));
      });
    }
  }
  String _statusCode;
  String _message;
  List<SubtestDetailsList> _subtestDetailsList;

  String get statusCode => _statusCode;
  String get message => _message;
  List<SubtestDetailsList> get subtestDetailsList => _subtestDetailsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_subtestDetailsList != null) {
      map['subtest_details_list'] = _subtestDetailsList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// test_type_id : "1"
/// subtest : "Free Test Subtest"
/// syllabus : null
/// zoom_link : null
/// syllabus_pdf : null
/// quation_paper_pdf : "https://indialearner.in/admin/uploads/sudhir.pdf"
/// answer_format_pdf : "https://indialearner.in/admin/uploads/sudhir1.pdf"

class SubtestDetailsList {
  SubtestDetailsList({
    String id,
    String testTypeId,
    String subtest,
    dynamic syllabus,
    dynamic zoomLink,
    dynamic syllabusPdf,
    String quationPaperPdf,
    String answerFormatPdf,
  }) {
    _id = id;
    _testTypeId = testTypeId;
    _subtest = subtest;
    _syllabus = syllabus;
    _zoomLink = zoomLink;
    _syllabusPdf = syllabusPdf;
    _quationPaperPdf = quationPaperPdf;
    _answerFormatPdf = answerFormatPdf;
  }

  SubtestDetailsList.fromJson(dynamic json) {
    _id = json['id'];
    _testTypeId = json['test_type_id'];
    _subtest = json['subtest'];
    _syllabus = json['syllabus'];
    _zoomLink = json['zoom_link'];
    _syllabusPdf = json['syllabus_pdf'];
    _quationPaperPdf = json['quation_paper_pdf'];
    _answerFormatPdf = json['answer_format_pdf'];
  }
  String _id;
  String _testTypeId;
  String _subtest;
  dynamic _syllabus;
  dynamic _zoomLink;
  dynamic _syllabusPdf;
  String _quationPaperPdf;
  String _answerFormatPdf;

  String get id => _id;
  String get testTypeId => _testTypeId;
  String get subtest => _subtest;
  dynamic get syllabus => _syllabus;
  dynamic get zoomLink => _zoomLink;
  dynamic get syllabusPdf => _syllabusPdf;
  String get quationPaperPdf => _quationPaperPdf;
  String get answerFormatPdf => _answerFormatPdf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['test_type_id'] = _testTypeId;
    map['subtest'] = _subtest;
    map['syllabus'] = _syllabus;
    map['zoom_link'] = _zoomLink;
    map['syllabus_pdf'] = _syllabusPdf;
    map['quation_paper_pdf'] = _quationPaperPdf;
    map['answer_format_pdf'] = _answerFormatPdf;
    return map;
  }
}
