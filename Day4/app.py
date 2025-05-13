from flask import Flask, request, jsonify
from aws import upload_to_s3
from models import init_db, save_metadata 
import os

app = Flask(__name__)
init_db()

@app.route('/upload',methods=['POST'])
def upload():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400

    file = request.files('file')
    if file.filename == '':
        return jsonify({'error': 'file not found'}), 400
    
    s3_url = upload_to_s3(file)
    metadata = {
        'filename': file.filename,
        's3_url': s3_url,
        'ip' : request.remote_addr
        
    }

    save_metadata(metadata)
    return jsonify({'message': 'File uploaded', 'url': s3_url}), 200

    if __name__ == '__main__':
        app.run(debug=TRUE)