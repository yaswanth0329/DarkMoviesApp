import 'package:flutter/material.dart';
import 'recommendation_service.dart'; // We’ll define this separately
import 'package:url_launcher/url_launcher.dart';

class MovieDetail extends StatefulWidget {
  final String movieTitle;

  const MovieDetail({required this.movieTitle,  super.key});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late Future<List<dynamic>> _recommendations;

  @override
  void initState() {
    super.initState();
    _recommendations = getRecommendations(widget.movieTitle);
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movieTitle)),
      body: FutureBuilder<List<dynamic>>(
        future: _recommendations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading recommendations"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No recommendations found"));
          }

          final movies = snapshot.data!;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, index) {
              var movie = movies[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(movie['title']),
                  subtitle: Text(movie['summary']),
                  trailing: IconButton(
                    icon: Icon(Icons.play_circle),
                    onPressed: () {
                      final url = movie['platforms']['Netflix'];
                      _launchURL(url);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}