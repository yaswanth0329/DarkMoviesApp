import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getRecommendations(String title) async {
  final response = await http.post(
    Uri.parse("https://darkmovieapp.onrender.com/recommend"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"title": title}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to load recommendations");
  }
}