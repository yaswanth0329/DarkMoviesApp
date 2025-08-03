import 'package:flutter/material.dart';
import 'movie_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
// Adjust the import based on your project structure
 // Ensure this import matches your project structure  
// Import the API service to fetch recommendations

class DarkMoviesApp extends StatelessWidget {
  DarkMoviesApp({super.key});
  final List<Map<String, dynamic>> movies = [
    {
      "title": "Inception",
      "summary": "A thief enters dreams to steal secrets.",
      "image_url": "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_.jpg"
    },
    {
      "title": "The Batman",
      "summary": "Batman fights crime and corruption in Gotham.",
      "image_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrzzFYczgufsR1VZbadYvtIvRKYnNnb8tz9w&s"
    },
    {
      "title": "The Incredible Hulk",
      "summary": "Bruce Banner, a scientist on the run from the U.S. Government, must find a cure for the monster he turns into whenever he loses his temper.",
      "image_url": "https://m.media-amazon.com/images/M/MV5BMTUyNzk3MjA1OF5BMl5BanBnXkFtZTcwMTE1Njg2MQ@@._V1_.jpg"
    },
    {
      "title": "The Shawshank Redemption",
      "summary": "A banker convicted of uxoricide forms a friendship over a quarter century with a hardened convict, while maintaining his innocence and trying to remain hopeful through simple compassion.",
      "image_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb9670Mi_MG5ezDhuF-mDPXtisIFZZPiHyzw&s"
    },
    {
      "title": "The Godfather",
      "summary": "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
      "image_url": "https://m.media-amazon.com/images/M/MV5BNGEwYjgwOGQtYjg5ZS00Njc1LTk2ZGEtM2QwZWQ2NjdhZTE5XkEyXkFqcGc@._V1_.jpg"
    },
    {
      "title": "The Dark Knight",
      "summary": "When a menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman, James Gordon and Harvey Dent must work together to put an end to the madness.",
      "image_url": "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_FMjpg_UX1000_.jpg"
    },
    {
      "title": "Fight Club",
      "summary": "An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into much more.",
      "image_url": "https://m.media-amazon.com/images/M/MV5BOTgyOGQ1NDItNGU3Ny00MjU3LTg2YWEtNmEyYjBiMjI1Y2M5XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"
    },
    {
      "title": "The Matrix",
      "summary": "When a beautiful stranger leads computer hacker Neo to a forbidding underworld, he discovers the shocking truth--the life he knows is the elaborate deception of an evil cyber-intelligence.",
      "image_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfSjSWOCaw5dnDL2GT1zFd9RMCgUGw5Q2Cfg&s"
    },
    {
      "title": "Terminator 2: Judgment Day",
      "summary": "A cyborg, identical to the one who failed to kill Sarah Connor, must now protect her ten year old son John from an even more advanced and powerful cyborg.",
      "image_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdiiEkFxkev2ZCxNl25GG7Pq-VFTvdzsZXXg&s"
    },
    {
      "title": "Avengers: Endgame",
      "summary": "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.",
      "image_url": "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_FMjpg_UX1000_.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DarkMovies")),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          var movie = movies[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: movie['image_url'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              title: Text(movie['title']),
              subtitle: Text(movie['summary']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetail(movieTitle: movie['title']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}