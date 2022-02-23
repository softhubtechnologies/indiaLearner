class AdvertiseModel {
  String statusCode;
  String message;
  List<AdvertiesmentList> advertiesmentList;

  AdvertiseModel({this.statusCode, this.message, this.advertiesmentList});

  AdvertiseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['advertiesment_list'] != null) {
      advertiesmentList = new List<AdvertiesmentList>();
      json['advertiesment_list'].forEach((v) {
        advertiesmentList.add(new AdvertiesmentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.advertiesmentList != null) {
      data['advertiesment_list'] = this.advertiesmentList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvertiesmentList {
  String id;
  String categoryId;
  String description;
  String imagePath;

  AdvertiesmentList({this.id, this.categoryId, this.description, this.imagePath});

  AdvertiesmentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    description = json['description'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['image_path'] = this.imagePath;
    return data;
  }
}
