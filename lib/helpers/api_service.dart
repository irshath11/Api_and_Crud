import 'dart:convert';
import 'dart:developer';
import 'package:api_pagination_task/model/photo_screen_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/photos";

  Future<List<PhotoScreenModel>> fetchPhotos(int start, int limit) async {
    String url = "$baseUrl?_start=$start&_limit=$limit";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PhotoScreenModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load photos");
    }
  }
}
