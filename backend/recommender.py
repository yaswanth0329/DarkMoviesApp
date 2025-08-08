import json
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Load the data
with open("movies.json", encoding="utf-8") as f:
    movies = json.load(f)

summaries = [m["summary"] for m in movies]
titles = [m["title"] for m in movies]

# Mapping for quick image lookup
title_to_data = {m["title"]: m for m in movies}

# TF-IDF vector
vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(summaries)

def get_similar_movies(title):
    if title not in titles:
        return [{"title": "Movie not found", "summary": "", "image_url": ""}]

    # Custom hardcoded recommendations (optional)
    if title == "Inception":
        return [
            title_to_data.get("Interstellar", {}),
            title_to_data.get("The Matrix", {}),
        ]
    elif title == "The Godfather":
        return [
            title_to_data.get("Tenet", {}),
            title_to_data.get("Shutter Island", {}),
        ]
    elif title == "The Batman":
        return [
            title_to_data.get("Tenet", {}),
            title_to_data.get("Shutter Island", {}),
        ]
    else:
        idx = titles.index(title)
        cosine_similarities = cosine_similarity(X[idx], X).flatten()
        similar_indices = cosine_similarities.argsort()[-6:][::-1]  # Top 5 excluding itself

        similar_movies = []
        for i in similar_indices:
            if i != idx:
                movie = movies[i]
                similar_movies.append({
                    "title": movie["title"],
                    "summary": movie["summary"],
                    "image_url": movie.get("image_url", "")
                })

        return similar_movies
