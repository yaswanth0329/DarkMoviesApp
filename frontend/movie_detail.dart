import 'package:flutter/material.dart';
import 'recommendation_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetail extends StatefulWidget {
  final String movieTitle;

  const MovieDetail({required this.movieTitle, super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movieTitle)),
      body: FutureBuilder<List<dynamic>>(
        future: _recommendations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading recommendations"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No recommendations found"));
          }

          final movies = snapshot.data!;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, index) {
              var movie = movies[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: movie['image_url'] ?? '',
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  title: Text(movie['title']),
                  subtitle: Text(movie['summary']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
