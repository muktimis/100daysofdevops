!# /usr/bin/env bash

yum update -y
yum install -y python3 git
pip3 install flask

cat <<EOF> /home/ec2-user/app.py
from flask import Flask
app = Flask(__name_)
@app.route("/")
def hello():
    return "welcome to mukti's flask app"
if __name__ == "__main__":
    app.run("0.0.0.0",port=80)
EOF

nohup python3/home/ec2-user/app.py &