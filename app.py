from flask import Flask, jsonify, request
import mysql.connector
import os

app = Flask(__name__)



mysql_config = {
    'host': os.environ.get('MYSQL_HOST', 'localhost'),
    'port': int(os.environ.get('MYSQL_PORT', 3306)),  # Specify the port separately
    'user': os.environ.get('MYSQL_USER', 'root'),
    'password': os.environ.get('MYSQL_PASSWORD', ''),
    'database': os.environ.get('MYSQL_DATABASE', 'bible')
}

# Connect to MySQL database
conn = mysql.connector.connect(**mysql_config)
cursor = conn.cursor(dictionary=True)

@app.route("/", methods=['GET'])
def hello_world():
    return "<p>Hello, World!</p>"


@app.route('/verse', methods=['GET'])
def get_verses():
    try:
        start_id = request.args.get('start_id')
        end_id = request.args.get('end_id')

        if not start_id or not end_id:
            return jsonify({'error': 'Start ID and end ID are required'}), 400

        cursor.execute("SELECT * FROM t_asv WHERE id BETWEEN %s AND %s", (start_id, end_id))
        users = cursor.fetchall()
        return jsonify(users)
    except Exception as e:
        return jsonify({'error': str(e)}), 500



@app.route('/users', methods=['POST'])
def add_user():
    try:
        data = request.form
        name = data.get('name')

        if not name:
            return jsonify({'error': 'Name is required'}), 400

        cursor.execute("INSERT INTO users (name) VALUES (%s)", (name,))
        conn.commit()

        return jsonify({'message': 'User added successfully'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500
        

if __name__ == '__main__':
    app.run(debug=True)
