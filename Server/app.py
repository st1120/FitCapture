from flask import Flask, request, jsonify
import os

import inference

app = Flask(__name__)
UPLOAD_FOLDER = 'static/uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

@app.route('/upload', methods=['POST'])
def upload_file():
    if request.method == 'POST':
        file = request.files['file']
        height = request.form.get('height', type=int)
        if file and height:
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], file.filename))
            res = inference.run(os.path.join(app.config['UPLOAD_FOLDER'], file.filename), height)
            return jsonify(res)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
