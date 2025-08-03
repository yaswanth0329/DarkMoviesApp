import recommender

results = recommender.get_similar_movies("Inception")
for movie in results:
  print(movie["title"])