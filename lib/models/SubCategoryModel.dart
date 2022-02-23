class SubCategoryModel {
  String statusCode;
  String message;
  List<SubcategoryList> subcategoryList;

  SubCategoryModel({this.statusCode, this.message, this.subcategoryList});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
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
  String subcategoryId;
  String categoryId;
  String subcategory;
  String isClass;

  SubcategoryList({this.subcategoryId, this.categoryId, this.subcategory, this.isClass});

  SubcategoryList.fromJson(Map<String, dynamic> json) {
    subcategoryId = json['subcategory_id'];
    categoryId = json['category_id'];
    subcategory = json['subcategory'];
    isClass = json['is_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategory_id'] = this.subcategoryId;
    data['category_id'] = this.categoryId;
    data['subcategory'] = this.subcategory;
    data['is_class'] = this.isClass;
    return data;
  }
}
