import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/photos";

  Future<List<dynamic>> fetchPhotos(int start, int limit) async {
    String url = "$baseUrl?_start=$start&_limit=$limit";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("api response: ${response.body}");
      return jsonDecode(response.body);
    } else {  
      throw Exception("Failed to load photos");
    }
  }
}
