from flask import Flask, request, jsonify
from flask_cors import CORS
import recommender  # This will import from recommender.py

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    return '✅ API is working'

@app.route('/recommend', methods=['POST'])
def recommend():
    data = request.json
    title = data.get("title")
    
    if not title:
        return jsonify({"error": "Title is required"}), 400
    
    results = recommender.get_similar_movies(title)
    return jsonify(results)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=10000, debug=True)