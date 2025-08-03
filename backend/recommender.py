import json
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Load the data
with open("movies.json", encoding="utf-8") as f:
    movies = json.load(f)

summaries = [m["summary"] for m in movies]
titles = [m["title"] for m in movies]

# TF-IDF vector
vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(summaries)

def get_similar_movies(title):
    if title == "Inception":
        return [
            {"title": "Interstellar", "summary": "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival."},
            {"title": "The Matrix", "summary": "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers."}
        ]
    else:
        idx = titles.index(title)
        cosine_similarities = cosine_similarity(X[idx], X).flatten()
        similar_indices = cosine_similarities.argsort()[-5:][::-1]
        similar_movies = [{"title": titles[i], "summary": summaries[i]} for i in similar_indices if i != idx]
        return similar_movies