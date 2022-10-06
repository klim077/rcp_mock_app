import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
// import 'package:myapp/blocs/config_bloc.dart';
import 'config.dart';
import 'dart:io';
import 'dart:convert';
// import 'package:myapp/repositories/user_repository.dart';

import 'error_constant.dart';

enum AuthScheme {
  ApiKey,
  Jwt,
}

class OpenApiClient {
  // final AuthScheme authScheme;
  OpenApiClient();
  final storage = new FlutterSecureStorage();

  

//Get Request
  Future<http.Response> get({
    required String endPoint,
    String method = '',
    Map<String, dynamic>? qParams,
    Map<String, String>? headers,
    bool requiredJWT = true,
    bool mongoVersion = true,
    bool isHttps = false,
  }) async {
    if (mongoVersion) {
      method = "/" + mongoApiVersion + "/" + method;
    }
    Uri url;
    if (qParams == null) {
      if (isHttps) {
        url = Uri.https(endPoint, method);
      } else {
        url = Uri.http(endPoint, method);
      }
    } else {
      if (isHttps) {
        url = Uri.https(endPoint, method, qParams);
      } else {
        url = Uri.http(endPoint, method, qParams);
      }
    }
    if (requiredJWT) {
      headers = await makeHeaders(
          requiredJWT: requiredJWT, additionalHeader: headers);

      try {
        http.Response response = await http.get(url, headers: headers);
        return response;
      } catch (err) {
        print(err);
        throw Exception(API_GET_ERROR + ' Method : $method');
      }
    } else {
      if (headers == null) {
        try {
          http.Response response = await http.get(url);
          return response;
        } catch (err) {
          print(err);
          throw Exception(API_GET_ERROR + ' Method : $method');
        }
      } else {
        try {
          http.Response response = await http.get(url, headers: headers);

          return response;
        } catch (err) {
          print(err);
          throw Exception(API_GET_ERROR + ' Method : $method');
        }
      }
    }
  }

  //Post Request
  Future<http.Response> post({
    required String endPoint,
    required String method,
    Map<String, dynamic>? body = const {"none": "none"},
    Map<String, dynamic>? qParams,
    Map<String, String>? headers,
    bool requiredJWT = true,
    bool mongoVersion = true,
    bool isHttps = false,
  }) async {
    Uri url;
    http.Response response;
    print("current endpoint is : " + endPoint);
    if (mongoVersion) {
      method = "/" + mongoApiVersion + "/" + method;
    }
    // if (qParams == null) {
    //   url = Uri.https(endPoint, method);
    // } else {
    //   url = Uri.https(endPoint, method);
    // }
    String jsonEncodeBody = jsonEncode(body);
    if (qParams == null) {
      if (isHttps) {
        url = Uri.https(endPoint, method);
      } else {
        url = Uri.http(endPoint, method);
      }
    } else {
      if (isHttps) {
        url = Uri.https(endPoint, method, qParams);
      } else {
        url = Uri.http(endPoint, method, qParams);
      }
    }
    if (requiredJWT) {
      headers = await makeHeaders(
          requiredJWT: requiredJWT, additionalHeader: headers);

      if (body != {"none": "none"}) {
        try {
          http.Response response =
              await http.post(url, headers: headers, body: jsonEncodeBody);

          return response;
        } catch (err) {
          print(err);
          throw Exception(API_POST_ERROR + ' Method : $method');
        }
      } else {
        try {
          http.Response response = await http.post(url, headers: headers);

          return response;
        } catch (err) {
          print(err);
          throw Exception(API_POST_ERROR + ' Method : $method');
        }
      }
    } else {
      if (headers == null) {
        try {
          http.Response response = await http.post(url, body: jsonEncodeBody);
          return response;
        } catch (err) {
          print(err);
          throw Exception(API_POST_ERROR + ' Method : $method');
        }
      } else {
        try {
          if (jsonEncodeBody == jsonEncode({"none": "none"})) {
            response = await http.post(url, headers: headers);
          } else {
            response =
                await http.post(url, body: jsonEncodeBody, headers: headers);
          }

          return response;
        } catch (err) {
          print(err);
          throw Exception(API_POST_ERROR + ' Method : $method');
        }
      }
    }
  }

  //Delete Request
  Future<http.Response> delete({
    required String endPoint,
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiredJWT = true,
    bool mongoVersion = true,
    bool isHttps = false,
  }) async {
    if (mongoVersion) {
      method = "/" + mongoApiVersion + "/" + method;
    }

    Uri url;

    url = Uri.https(endPoint, method);

    if (requiredJWT) {
      headers = await makeHeaders(
          requiredJWT: requiredJWT, additionalHeader: headers);
      try {
        http.Response response = await http.delete(url, headers: headers);

        return response;
      } catch (err) {
        print(err);
        throw Exception(API_DELETE_ERROR + ' Method : $method');
      }
    } else {
      if (headers == null) {
        try {
          http.Response response = await http.delete(url);
          return response;
        } catch (err) {
          print(err);
          throw Exception(API_DELETE_ERROR + ' Method : $method');
        }
      } else {
        try {
          http.Response response = await http.delete(url, headers: headers);

          return response;
        } catch (err) {
          print(err);
          throw Exception(API_DELETE_ERROR + ' Method : $method');
        }
      }
    }
  }

  //Patch Request
  Future<http.Response> patch({
    required String endPoint,
    required String method,
    Map<String, dynamic>? qParams,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiredJWT = true,
    bool mongoVersion = true,
    bool isHttps = false,
  }) async {
    Uri url;
    String patchBody;

    if (mongoVersion) {
      method = "/" + mongoApiVersion + "/" + method;
    }

    if (qParams == null) {
      url = Uri.https(endPoint, method);
    } else {
      url = Uri.https(endPoint, method, qParams);
    }
    try {
      patchBody = jsonEncode(body);
    } catch (error) {
      throw Exception(API_BODY_JSON_ENCODE_ERROR + ' Method : $method');
    }

    if (headers == null && requiredJWT == false) {
      try {
        http.Response response = await http.patch(url);
        return response;
      } catch (err) {
        print(err);
        throw Exception(API_PATCH_ERROR + ' Method : $method');
      }
    } else {
      if (requiredJWT) {
        headers = await makeHeaders(
            requiredJWT: requiredJWT, additionalHeader: headers);

        try {
          http.Response response = await http.patch(url, headers: headers);

          return response;
        } catch (err) {
          print(err);
          throw Exception(API_POST_ERROR + ' Method : $method');
        }
      } else {
        try {
          http.Response response =
              await http.patch(url, headers: headers, body: patchBody);

          return response;
        } catch (err) {
          print(err);
          throw Exception(API_PATCH_ERROR + ' Method : $method');
        }
      }
    }
  }

  Future<Map<String, String>> makeHeaders({
    bool requiredJWT = false,
    Map<String, String>? additionalHeader,
  }) async {
    Map<String, String> httpHeaders = Map<String, String>();
    if (requiredJWT) {
      final String? token = await getToken();
      final String jwtAuth = 'Bearer $token';

      httpHeaders[HttpHeaders.authorizationHeader] = jwtAuth;
      httpHeaders[HttpHeaders.contentTypeHeader] = 'application/json';
      httpHeaders[HttpHeaders.acceptHeader] = 'application/json';
    } else {
      httpHeaders[HttpHeaders.contentTypeHeader] = 'application/json';
      httpHeaders[HttpHeaders.acceptHeader] = 'application/json';
    }
    if (additionalHeader != null && additionalHeader.isNotEmpty) {
      for (String key in additionalHeader.keys) {
        httpHeaders[key] = additionalHeader[key]!;
      }
    }
    return httpHeaders;
  }

  Future<String?> getToken() async {
    // Read value
    String? token = await storage.read(key: "LastToken");
    return token;
  }
}
