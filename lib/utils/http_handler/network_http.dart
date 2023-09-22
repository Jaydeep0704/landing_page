// The best way to handle network requests in Flutter
// Applications frequently need to perform POST and GET and other HTTP requests.
// Flutter provides an http package that supports making HTTP requests.

// HTTP methods: GET, POST, PATCH, PUT, DELETE

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/config/api_string.dart';
import 'package:grobiz_web_landing/config/local_storage.dart';
import 'package:grobiz_web_landing/utils/shared_preference/shared_preference_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HttpHandler {
  static String baseURL = APIString.grobizBaseUrl;

  static Future<Map<String, String>> _getHeaders() async {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // if (token != null) 'Authorization': "Bearer $token",
      // if (id != null) "id": id,
    };
  }

  static Future<Map<String, dynamic>> formDataMethod(
      {required String url,
      Map<String, String>? body,
      String? imagePath,
      String? apiMethod,
      List<String>? imageList,
      String? dynamicToken,
      bool isMimeType = false,
      String? imageKey}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(
      LocalStorage.token,
    );
    var request = http.MultipartRequest(
      (apiMethod ?? "POST").toUpperCase(),
      Uri.parse(
        "$baseURL$url",
      ),
    );
    debugPrint("POST FORM DATA URL ----  $request");
    debugPrint("POST TOKEN DATA URL ----  $token");
    request.headers.addAll(
      {
        if (token != null) 'Authorization': "Bearer $token",
        'Content-Type': 'multipart/form-data',
        if (isMimeType == true) "mimeType": "image/png"
        // 'Content-Type': 'application/json;charset=UTF-8',
        // 'Charset': 'utf-8'
      },
      /*  {
          if (dynamicToken != null)
            'x-api-key': dynamicToken
          else if (token != null)
            'x-api-key': token,
          'Content-Type':
              'multipart/form-data; boundary=<calculated when request is sent>'
        },*/
    );

    debugPrint("FORM DATA BODY :-  $body");

    if (imagePath != null) {
      debugPrint("image -- $imagePath");
      request.files.add(
        await http.MultipartFile.fromPath(
          '$imageKey',
          imagePath,
        ),
      );
    }
    if (imageList != null) {
      for (var element in imageList) {
        request.files.add(
          await http.MultipartFile.fromPath(
            '$imageKey',
            element,
          ),
        );
      }
    }
    if (body != null) {
      request.fields.addAll(body);
    }
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    String responseString = String.fromCharCodes(responseData);
    debugPrint("RESPONSE $url = $responseString");
    debugPrint("RESPONSE CODE = ${response.statusCode}");

    if (response.statusCode == 200) {
      var data = json.decode(
        responseString,
      );
      Map<String, dynamic> returnRes = {
        'body': data,
        'error': null,
      };
      return returnRes;
    } else {
      Map<String, dynamic> returnRes = {
        'body': responseString,
        'error': "${response.statusCode}",
      };
      debugPrint('Something went wrong');
      return returnRes;
    }
  }

  static Future<Map<String, dynamic>> getHttpMethod({
    @required String? url,
    bool isMockUrl = false,
  }) async {
    var header = await _getHeaders();
    debugPrint("Get URL -- '$baseURL$url'");
    http.Response response = await http.get(
      // Uri.parse(isMockUrl ? "$url" : "$baseURL$url"),
      Uri.parse(
          "https://frontbitsolutions.com/team_testing/dhruvin_savaliya/test.json"),
      headers: header,
    );
    var res = handler(response);
    return res;
  }

  static Future<Map<String, dynamic>> postHttpMethod({
    @required String? url,
    Map<String, dynamic>? data,
  }) async {
    var header = await _getHeaders();
    debugPrint("Post URL -- '$baseURL$url'");
    debugPrint("Post Data -- '${data.toString()}'");
    http.Response response = await http.post(
      Uri.parse("$baseURL$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    var res = handler(response);
    return res;
  }

  static Future<Map<String, dynamic>> patchHttpMethod({
    @required String? url,
    Map<String, dynamic>? data,
  }) async {
    var header = await _getHeaders();
    debugPrint("Patch URL -- '$baseURL$url'");
    debugPrint("Patch Data -- '$data'");
    http.Response response = await http.patch(
      Uri.parse("$baseURL$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    var res = handler(response);
    return res;
  }

  static Future<Map<String, dynamic>> putHttpMethod({
    @required String? url,
    Map<String, dynamic>? data,
  }) async {
    var header = await _getHeaders();
    debugPrint("Put URL -- '$baseURL$url'");
    debugPrint("Put Data -- '$data'");
    http.Response response = await http.put(
      Uri.parse("$baseURL$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    var res = handler(response);
    return res;
  }

  static Future<Map<String, dynamic>> deleteHttpMethod({
    @required String? url,
  }) async {
    var header = await _getHeaders();
    debugPrint("Delete URL -- '$baseURL$url'");
    http.Response response =
        await http.delete(Uri.parse("$baseURL$url"), headers: header);
    var res = handler(response);
    return res;
  }

  static Map<String, dynamic> handler(http.Response response) {
    debugPrint(" Response Code -- '${response.statusCode}'");
    debugPrint(" Response -- '${response.body}'");
    if (response.statusCode == 200) {
      return {
        'body': jsonDecode(response.body),
        'headers': response.headers,
        'error': null,
      };
    } else {
      return {
        'body': response.body,
        'headers': response.headers,
        'error': "${response.statusCode}",
      };
    }
  }
}
