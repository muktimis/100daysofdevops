from flask import Flask
import logging

app = Flask(__name__)

# logging.basicConfig(filename='/var/log/flask-app.log',level=logging.INFO, format='%(asctime)s %(message)s')
logging.basicConfig(filename='/var/log/flask-app.log', level=logging.INFO, format='%(asctime)s %(message)s')


@app.route('/')

def hello():
    app.logger.info('Homepage accessed')
    return 'Hello ELK'

# if __name__ == '__main__':
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
