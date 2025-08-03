import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchRecommendations(String title) async {
  final url = Uri.parse("https://darkmovieapp.onrender.com/recommend"); // Use proper IP based on your setup

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"title": title}),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => item.toString()).toList();
  } else {
    throw Exception('Failed to fetch recommendations');
  }
}