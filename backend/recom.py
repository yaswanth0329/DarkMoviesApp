import json
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

with open("movies.json") as f:
    movies = json.load(f)

summaries = [m["summary"] for m in movies]
titles = [m["title"] for m in movies]

vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(summaries)

def get_similar_movies(title):
    try:
        idx = titles.index(title)
        sims = cosine_similarity(X[idx], X).flatten()
        top = sims.argsort()[::-1][1:6]  # Top 5 except itself
        return [movies[i] for i in top]
    except ValueError:
        return []