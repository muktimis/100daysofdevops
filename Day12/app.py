from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def home():
    """Root endpoint."""
    return jsonify({"message": "Welcome to the Flask CI/CD Code Scan Demo!"})

@app.route('/hello/<name>', methods=['GET'])
def hello_name(name):
    """Returns a greeting message."""
    return jsonify({"message": f"Hello, {name}!"})

@app.route('/add', methods=['POST'])
def add_numbers():
    """Adds two numbers from JSON payload."""
    data = request.get_json()
    num1 = data.get('num1', 0)
    num2 = data.get('num2', 0)

    # Validate input
    if not isinstance(num1, (int, float)) or not isinstance(num2, (int, float)):
        return jsonify({"error": "Inputs must be numbers"}), 400

    result = num1 + num2
    return jsonify({"result": result})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
