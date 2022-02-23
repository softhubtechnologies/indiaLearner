/// status_code : "200"
/// message : "Success"
/// plan_list : [{"id":"1","category_id":"1","plan_name":"1 Month","duration":"30","price":"5000"},{"id":"2","category_id":"1","plan_name":"3 Month","duration":"90","price":"10000"},{"id":"3","category_id":"1","plan_name":"6 Month","duration":"180","price":"15000"},{"id":"4","category_id":"1","plan_name":"12 Month","duration":"360","price":"20000"},{"id":"5","category_id":"1","plan_name":"24 Month","duration":"720","price":"30000"}]

class PlansModel {
  PlansModel({
    String statusCode,
    String message,
    List<Plan_list> planList,
  }) {
    _statusCode = statusCode;
    _message = message;
    _planList = planList;
  }

  PlansModel.fromJson(dynamic json) {
    _statusCode = json['status_code'];
    _message = json['message'];
    if (json['plan_list'] != null) {
      _planList = [];
      json['plan_list'].forEach((v) {
        _planList.add(Plan_list.fromJson(v));
      });
    }
  }
  String _statusCode;
  String _message;
  List<Plan_list> _planList;

  String get statusCode => _statusCode;
  String get message => _message;
  List<Plan_list> get planList => _planList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_planList != null) {
      map['plan_list'] = _planList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// category_id : "1"
/// plan_name : "1 Month"
/// duration : "30"
/// price : "5000"

class Plan_list {
  Plan_list({
    String id,
    String categoryId,
    String planName,
    String duration,
    String price,
  }) {
    _id = id;
    _categoryId = categoryId;
    _planName = planName;
    _duration = duration;
    _price = price;
  }

  Plan_list.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _planName = json['plan_name'];
    _duration = json['duration'];
    _price = json['price'];
  }
  String _id;
  String _categoryId;
  String _planName;
  String _duration;
  String _price;

  String get id => _id;
  String get categoryId => _categoryId;
  String get planName => _planName;
  String get duration => _duration;
  String get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['plan_name'] = _planName;
    map['duration'] = _duration;
    map['price'] = _price;
    return map;
  }
}
