class CategoriesModel {
  String statusCode;
  List<CategoryList> categoryList;

  CategoriesModel({this.statusCode, this.categoryList});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['Status_code'];
    if (json['Category_list'] != null) {
      categoryList = new List<CategoryList>();
      json['Category_list'].forEach((v) {
        categoryList.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status_code'] = this.statusCode;
    if (this.categoryList != null) {
      data['Category_list'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String id;
  String categoryName;
  String categoryImage;

  CategoryList({this.id, this.categoryName, this.categoryImage});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    return data;
  }
}
