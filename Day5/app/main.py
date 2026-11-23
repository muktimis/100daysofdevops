from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/analyze',method['POST'])

def analyze():
    log_data = request.get_data(as_Text=True)
    lines =  log_data.split('\n')
    error_lines = [line for line in lines if "Error" in line]
    return jsonify({
        "total_lines" : len(lines)
        "error_lines" : len(error_lines)
    })

if __name__ == "__main__":
    app.run(host='0.0.0.0',port=5000)


