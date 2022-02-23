class LoginModel {
  String statusCode;
  Result result;

  LoginModel({this.statusCode, this.result});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['Status_code'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status_code'] = this.statusCode;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String userId;
  String firstName;
  String lastName;
  String mobileNumber;
  String email;
  String bio;
  String categoryName;
  String categoryId;
  String subcategoryId;

  Result({this.userId, this.firstName, this.lastName, this.mobileNumber, this.email, this.bio, this.categoryName, this.categoryId, this.subcategoryId});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    bio = json['bio'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    return data;
  }
}
