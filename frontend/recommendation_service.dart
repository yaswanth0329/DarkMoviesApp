import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getRecommendations(String title) async {
  final url = Uri.parse("https://darkmoviesapp.onrender.com/recommend");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"title": title}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to load recommendations");
  }
}
