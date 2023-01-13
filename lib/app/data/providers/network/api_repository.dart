// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_endpoints.dart';

enum StatusResponse { success, error }

class ApiRepository {
  Future<http.Response?> getMetod(String path, [String? token]) async {
    try {
      var headers = {'Authorization': token.toString()};
      final response =
          await http.get(Uri.parse(APIEndpoint.api + path), headers: headers);
      if (kDebugMode) {
        print("response request: ${response.request}");
        print("response statusCode: ${response.statusCode}");
      }

      return response;
    } catch (e) {
      http.Client().close();
      throw e.toString();
    }
  }

  Future<http.Response?> postMetod(String path, Object body,
      [String? token]) async {
    try {
      var headers = {'Authorization': token.toString()};
      final response = await http.post(Uri.parse(APIEndpoint.api + path),
          headers: headers, body: body);
      if (kDebugMode) {
        print("response request: ${response.request}");
        print("response statusCode: ${response.statusCode}");
      }
      return response;
    } catch (e) {
      http.Client().close();
      throw e.toString();
    }
  }

  Future<http.StreamedResponse?> postMetodFile(
      Map<String, String> headers,
      Map<String, String> fields,
      String pathUrl,
      File file,
      String param) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(APIEndpoint.api + pathUrl));
      request.fields.addAll(fields);
      var stream = http.ByteStream(DelegatingStream(file.openRead()));
      var length = await file.length();
      var multipartFile = http.MultipartFile(param, stream, length,
          filename: basename(file.path));
      request.files.add(multipartFile);
      request.headers.addAll(headers);
      request.followRedirects = false;
      var response = await request.send();
      if (kDebugMode) {
        print("response request: ${response.request}");
        print("response statusCode: ${response.statusCode}");
      }
      return response;
    } catch (e) {
      http.Client().close();
      throw e.toString();
    }
  }
}

class ResponseApi {
  final String? response;
  final StatusResponse statusResponse;
  final String? message;

  ResponseApi(this.response, this.statusResponse, this.message);

  static ResponseApi success({data}) {
    return ResponseApi(data, StatusResponse.success, null);
  }

  static ResponseApi error({data, String? message}) {
    return ResponseApi(data, StatusResponse.error, message);
  }
}
