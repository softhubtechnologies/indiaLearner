class WrittenTestModel {
  String statusCode;
  String message;
  List<SubcategoryList> subcategoryList;

  WrittenTestModel({this.statusCode, this.message, this.subcategoryList});

  WrittenTestModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['subcategory_list'] != null) {
      subcategoryList = new List<SubcategoryList>();
      json['subcategory_list'].forEach((v) {
        subcategoryList.add(new SubcategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.subcategoryList != null) {
      data['subcategory_list'] = this.subcategoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubcategoryList {
  String id;
  String categoryId;
  String subcategoryId;
  String testName;
  String mark;
  String mainsPaper;

  SubcategoryList({this.id, this.categoryId, this.subcategoryId, this.testName, this.mark, this.mainsPaper});

  SubcategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    testName = json['test_name'];
    mark = json['mark'];
    mainsPaper = json['mains_paper'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['test_name'] = this.testName;
    data['mark'] = this.mark;
    data['mains_paper'] = this.mainsPaper;
    return data;
  }
}
