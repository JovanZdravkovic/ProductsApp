import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;

class BaseService {
  const BaseService();

  Future<Response> get(String url) async {
    final response = await http.get(Uri.parse(url));
    return response;
  }

  Future<Response> create(String url, Map<String, dynamic> body) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),  
    );
    return response;
  }

  // Future<Response> update() {}
  // Future<Response> delete() {}
}