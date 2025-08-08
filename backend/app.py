from flask import Flask, request, jsonify
from flask_cors import CORS
import recommender  # your recommender.py file

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    return '✅ API is working'

@app.route('/recommend', methods=['POST'])
def recommend():
    print("✅ POST request received at /recommend")
    data = request.get_json()
    
    if not data or "title" not in data:
        return jsonify({"error": "Title is required"}), 400

    title = data["title"]
    results = recommender.get_similar_movies(title)
    return jsonify(results)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=10000, debug=True)
