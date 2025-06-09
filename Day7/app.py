from flask import Flask, request, jsonify

app = Flask(__name__)

tasks = []

@app.route('/tasks',methods=['GET'])
def get_tasks():
    return jsonify(tasks), 200

@app.route('/tasks',methods=['POST'])
def create_tasks():
    data = request.get_json()
    task = {
        'id': len(tasks) + 1,
        'title': data.get('title'),
        'done': False
    }
    tasks.append(task)
    return jsonify(task),201

@app.route('/tasks/<int:task_id>',methods=['PUT'])
def update_tasks():
    for task in tasks:
        if tasks['id'] == task_id:
            task['done'] = True
            return jsonify(task)
    return jsonify({'error':'Task not found'}),404

# @app.route('/tasks/<int>:<task_id',methods=['DELETE'])
@app.route('/tasks/<int:task_id>', methods=['DELETE'])

def delete_tasks(task_id):
    global tasks
    tasks = [task for task in tasks if task['id'] != task_id]
    return jsonify({'result': 'Task deleted'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000)
        



