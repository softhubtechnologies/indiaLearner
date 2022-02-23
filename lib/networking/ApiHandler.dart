import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHandler {
  static var client = http.Client();

  static Future<Map<String, dynamic>> postApi({String baseUrl, String endApi, var map}) async {
    var response = await client.post(baseUrl + endApi, body: map);

    Map<String, dynamic> mapResponse;
    try {
      if (response.statusCode == 200) {
        mapResponse = json.decode(response.body);
        print("RESPONSE ${response.body.toString()}");

        return mapResponse;
      }
    } catch (e) {
      print("ERROR ${e.toString()}");
    }
  }

  static Future<Map<String, dynamic>> getApi({String baseUrl, String endApi, var map}) async {
    var response = await client.get(baseUrl + endApi);

    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse;

      try {
        mapResponse = json.decode(response.body);
        print("RESPONSE ${response.body.toString()}");

        return mapResponse;
      } catch (e) {
        print("ERROR ${e.toString()}");
      }
    }
  }

  static Future<Map<String, dynamic>> putApi({String baseUrl, String endApi, var map}) async {
    var response = await client.put(baseUrl + endApi, body: map);
    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse;
      try {
        print("ERROR ${response.body.toString()}");

        mapResponse = json.decode(response.body);
        return mapResponse;
      } catch (e) {
        print("ERROR ${e.toString()}");
      }
    }
  }
}
