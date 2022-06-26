import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:some_flutter/models/PageResponse.dart';

class ApiClient{

  // final String baseUrl = "http://92.63.206.30:8000";

  final String baseUrl = "http://92.63.206.30:8000";

  Future<dynamic> getToken(String username, String password) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    final msg = jsonEncode({"username": username, "password": password});
    return http.post(
        Uri.parse("$baseUrl/api/v1/auth/signin"),
        body: msg,
        headers: headers);
  }

  Future<dynamic> sendSms(String phoneNumber) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    return http.get(
        Uri.parse("$baseUrl/api/v1/auth/restore?phoneNumber=$phoneNumber"),
        headers: headers);
  }

  Future<dynamic> getUSerInfo(String? token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    return http.get(
        Uri.parse("$baseUrl/api/v1/user/info"),
        headers: headers);
  }

  Future<dynamic> getActiveOrders(String? token, int page, int size) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    return http.get(
        Uri.parse("$baseUrl/api/v1/order/driver/all?page=$page&size=$size"),
        headers: headers);
  }

  // Future<dynamic> acceptOrder(String? token, int orderId) async {
  //   Map<String, String> headers = {
  //     HttpHeaders.contentTypeHeader: "application/json",
  //     HttpHeaders.authorizationHeader: "Bearer $token",
  //   };
  //   return http.get(
  //       Uri.parse("$baseUrl/api/v1/order/driver/all?page=$page&size=$size"),
  //       headers: headers);
  // }

  Future<PageResponse> getActiveOrdersFutureBuilder(String? token, int page, int size) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response  =  await http.get(
        Uri.parse("$baseUrl/api/v1/order/driver/all?page=$page&size=$size"),
        headers: headers);
    if (response.statusCode == 200){
      return PageResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Server responded: ${response.statusCode} body: ${response.body}");
    }
  }

  void showError(BuildContext context, String content) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
            label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }


}
