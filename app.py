from flask import Flask, jsonify, request, render_template, redirect, url_for, session
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

# MySQL configurations
db_config = {
    'user': 'root',
    'password': 'root',
    'host': 'localhost',
    'database': 'pi',
}

def get_db_connection():
    try:
        connection = mysql.connector.connect(**db_config)
        return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

@app.route('/')
def nutricao():
    return 'Nutrição saudável'

#################login do usuario###############
@app.route('/login', methods=['POST'])
def login():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    password = request.json['password']
    email = request.json['email']
    cursor.execute('SELECT * FROM users WHERE email = %s AND password = %s', (email, password))
    account = cursor.fetchone()
    cursor.close()
    connection.close()
    if account:
        return jsonify({'message': 'User logged successfully', 'user': {
        'id': account['id'],
        'name': account['name'],
        'email': account['email']
    }})
    else:
        return jsonify({'message': 'Incorrect credentials'})

###############Logout do usuario###############
@app.route('/login/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('name', None)
    return redirect(url_for('login'))

################Registro de usuário##############
@app.route('/login/register', methods=['POST'])
def register():
    connection = get_db_connection()
    cursor = connection.cursor()
    name = request.json['name']
    password = request.json['password']
    email = request.json['email']
    cursor.execute('INSERT INTO users (name, password, email) VALUES (%s, %s, %s)', (name, password, email))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'User created successfully'})

#################tela inicial do usuario logado###############
@app.route('/login/home')
def home():
    if 'loggedin' in session:
        return render_template('home.html', name=session['name'])
    return redirect(url_for('login'))

################perfil###############
@app.route('/login/profile')
def profile():
    if 'loggedin' in session:
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute('SELECT * FROM users WHERE id = %s', (session['id'],))
        account = cursor.fetchone()
        cursor.close()
        connection.close()
        return render_template('profile.html', account=account)
    return redirect(url_for('login'))

#################Diario alimentar###############
@app.route('/diary', methods=['GET'])
def get_diary():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM diary')
    diary = cursor.fetchall()
    cursor.close()
    connection.close()
    for entry in diary:
        entry['date'] = entry['date'].isoformat()
        entry['time'] = str(entry['time']) 
        entry['is_in_diet'] = bool(entry['is_in_diet']) 
    return jsonify(diary)

@app.route('/diary/<int:id>', methods=['GET'])
def get_diary_by_id(id):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM diary WHERE id = %s', (id,))
    diary = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(diary)

@app.route('/diary_new_meal', methods=['POST'])
def add_diary():
    connection = get_db_connection()
    cursor = connection.cursor()
    title = request.json['title']
    description = request.json['description']
    date = request.json['date']
    time = request.json['time']
    is_in_diet = request.json['is_in_diet']
    user_id = request.json['user_id']
    cursor.execute('INSERT INTO diary (title,description, date,time, is_in_diet, user_id) VALUES (%s, %s, %s, %s, %s, %s)', (title, description, date, time, is_in_diet, user_id))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'Diary added successfully'})

@app.route('/diary/<int:id>', methods=['PUT'])
def update_diary(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    title = request.json['title']
    description = request.json['description']
    date = request.json['date']
    time = request.json['time']
    is_in_diet = request.json['is_in_diet']
    cursor.execute('UPDATE diary SET title = %s, description = %s, date = %s, time = %s, is_in_diet = %s WHERE id = %s', (title, description, date, time, is_in_diet, id))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'Diary updated successfully'})

@app.route('/diary/<int:id>', methods=['DELETE'])
def delete_diary(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute('DELETE FROM diary WHERE id = %s', (id,))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'Diary deleted successfully'})

#################Plano alimentar###############
@app.route('/meal_plan', methods=['GET'])
def get_meal_plan():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM meal_plan')
    meal_plan = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(meal_plan)

@app.route('/meal_plan/<int:id>', methods=['GET'])
def get_meal_plan_by_id(id):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM meal_plan WHERE id = %s', (id,))
    meal_plan = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(meal_plan)

@app.route('/meal_plan', methods=['POST'])
def add_meal_plan():
    connection = get_db_connection()
    cursor = connection.cursor()
    title = request.json['title']
    quantity = request.json['quantity']
    meal = request.json['meal']
    cursor.execute('INSERT INTO meal_plan (title, quantity, meal) VALUES (%s, %s, %s)', (title, quantity, meal))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'meal added successfully'})

@app.route('/meal_plan/<int:id>', methods=['PUT'])
def update_meal_plan(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    title = request.json['title']
    quantity = request.json['quantity']
    meal = request.json['meal']
    cursor.execute('UPDATE meal_plan SET title = %s, quantity = %s, meal = %s WHERE id = %s', (title, quantity, meal, id))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'Meal plan updated successfully'})

@app.route('/meal_plan/<int:id>', methods=['DELETE'])
def delete_meal_plan(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute('DELETE FROM meal_plan WHERE id = %s', (id,))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'meal_plan deleted successfully'})

#################Informações nutricionais###############
@app.route('/nutritional_information', methods=['GET'])
def get_nutritional_information():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM nutritional_information')
    nutritional_information = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(nutritional_information)

@app.route('/nutritional_information/<int:id>', methods=['GET'])
def get_nutritional_information_by_id(id):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM nutritional_information WHERE id = %s', (id,))
    nutritional_information = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(nutritional_information)

@app.route('/nutritional_information', methods=['POST'])
def add_nutritional_information():
    connection = get_db_connection()
    cursor = connection.cursor()
    title = request.json['title']
    specification = request.json['specification']
    description = request.json['description']
    kcal = request.json['kcal']
    image = request.json['image']
    category = request.json['category']
    recommendation_category = request.json['recommendation_category']
    cursor.execute('INSERT INTO nutritional_information (title, specification, description, kcal, image, category, recommendation_category) VALUES (%s, %s, %s, %s, %s, %s, %s)', (title, specification, description, kcal, image, category, recommendation_category))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'Nutritional information added successfully'})

@app.route('/nutritional_information/<int:id>', methods=['PUT'])
def update_nutritional_information(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    title = request.json['title']
    specification = request.json['specification']
    description = request.json['description']
    kcal = request.json['kcal']
    image = request.json['image']
    category = request.json['category']
    cursor.execute('UPDATE nutritional_information SET title = %s, specification = %s, description = %s, kcal = %s, image = %s, category = %s WHERE id = %s', (title, specification, description, kcal, image, category, id))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'Nutritional information updated successfully'})

@app.route('/nutritional_information/<int:id>', methods=['DELETE'])
def delete_nutritional_information(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute('DELETE FROM nutritional_information WHERE id = %s', (id,))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'Nutritional information deleted successfully'})

#################Fale com um profissional###############
@app.route('/chat', methods=['GET'])
def get_chat():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM chat')
    chat = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(chat)

@app.route('/chat/<int:id>', methods=['GET'])
def get_chat_by_id(id):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM chat WHERE id = %s', (id,))
    chat = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(chat)

@app.route('/chat', methods=['POST'])
def add_chat():
    connection = get_db_connection()
    cursor = connection.cursor()
    subject = request.json['subject']
    description = request.json['description']
    user_id = request.json['user_id']
    created_at = request.json['created_at']
    cursor.execute('INSERT INTO chat (subject, description, user_id, created_at) VALUES (%s, %s, %s, %s)', (subject, description, user_id, created_at))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'chat information added successfully'})

@app.route('/chat/<int:id>', methods=['PUT'])
def update_chat(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    subject = request.json['subject']
    description = request.json['description']
    user_id = request.json['user_id']
    created_at = request.json['created_at']
    cursor.execute('UPDATE chat SET subject = %s, description = %s, user_id = %s, created_at = %s WHERE id = %s', (subject, description, user_id, created_at, id))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'chat information updated successfully'})

@app.route('/chat/<int:id>', methods=['DELETE'])
def delete_chat(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute('DELETE FROM chat WHERE id = %s', (id,))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'chat information deleted successfully'})

#################Agendar uma consulta###############
@app.route('/appointment', methods=['GET'])
def get_appointment():
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM appointment')
    appointment = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(appointment)

@app.route('/appointment/<int:id>', methods=['GET'])
def get_appointment_by_id(id):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute('SELECT * FROM appointment WHERE id = %s', (id,))
    appointment = cursor.fetchall()
    cursor.close()
    connection.close()
    return jsonify(appointment)

@app.route('/appointment', methods=['POST'])
def add_appointment():
    connection = get_db_connection()
    cursor = connection.cursor()
    professional_name = request.json['professional_name']
    date = request.json['date']
    time = request.json['time']
    user_id = request.json['user_id']
    cursor.execute('INSERT INTO appointment (professional_name, date, time, user_id) VALUES (%s, %s, %s, %s)', (professional_name, date, time, user_id))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'appointment information added successfully'})

@app.route('/appointment/<int:id>', methods=['PUT'])
def update_appointment(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    professional_name = request.json['professional_name']
    date = request.json['date']
    time = request.json['time']
    user_id = request.json['user_id']
    cursor.execute('UPDATE appointment SET professional_name = %s, date = %s, time = %s, user_id = %s WHERE id = %s', (professional_name, date, time, user_id, id))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'appointment updated successfully'})

@app.route('/appointment/<int:id>', methods=['DELETE'])
def delete_appointment(id):
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute('DELETE FROM appointment WHERE id = %s', (id,))
    connection.commit()
    cursor.close()
    connection.close()
    return jsonify({'message': 'appointment deleted successfully'})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)