from flask import Flask, jsonify, request, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import MySQLdb.cursors, re, hashlib

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'pi'
mysql = MySQL(app)

@app.route('/')
def nutricao():
    return 'Nutrição saudável'

#################login do usuario###############
@app.route('/login/', methods=['GET', 'POST'])
def login():
    msg = 'SYSTEM WITH ERROR'
    if request.method == 'POST' and 'name' in request.form and 'password' in request.form:
        name = request.form['name']
        password = request.form['password']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE name = %s AND password = %s', (name, password,))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['id'] = account['id']
            session['name'] = account['name']
            # Redirect to home page
            return 'Logged in successfully!'
        else:
            msg = 'Incorrect username/password!'
    return render_template('index.html', msg=msg)

###############Logout do usuario###############
@app.route('/login/logout')
def logout():
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('name', None)
   return redirect(url_for('login'))

################Registro de usuário##############
@app.route('/login/register', methods=['GET', 'POST'])
def register():
    msg = 'SYSTEM WITH ERROR'
    if request.method == 'POST' and 'name' in request.form and 'password' in request.form and 'email' in request.form:
        name = request.form['name']
        password = request.form['password']
        email = request.form['email']
    elif request.method == 'POST':
        msg = 'Please fill out the form!'
    return render_template('register.html', msg=msg)

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
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE id = %s', (session['id'],))
        account = cursor.fetchone()
        return render_template('profile.html', account=account)
    return redirect(url_for('login'))

#################Diario alimentar###############
@app.route('/diary', methods=['GET'])
def get_diary():
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM diary''')
    diary = cur.fetchall()
    cur.close()
    return jsonify(diary)

@app.route('/diary/<int:id>', methods=['GET'])
def get_diary_by_id(id):
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM diary WHERE id = %s''', (id,))
    diary = cur.fetchall()
    cur.close()
    return jsonify(diary)

@app.route('/diary_new_meal', methods=['POST'])
def add_diary():
    cur = mysql.connection.cursor()
    title = request.json['title']
    description = request.json['description']
    date = request.json['date']
    time = request.json['time']
    is_in_diet = request.json['is_in_diet']
    cur.execute('''INSERT INTO diary (title,description, date,time, is_in_diet) VALUES (%s, %s)''', (title, description, date, time, is_in_diet))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Diary added successfully'})

@app.route('/diary/<int:id>', methods=['PUT'])
def update_diary(id):
    cur = mysql.connection.cursor()
    title = request.json['title']
    description = request.json['description']
    date = request.json['date']
    time = request.json['time']
    is_in_diet = request.json['is_in_diet']
    cur.execute('''UPDATE diary SET title = %s, description = %s, date = %s, time = %s, is_in_diet = %s  WHERE id = %s''', (title, description, date, time, is_in_diet))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Diary updated successfully'})

@app.route('/diary/<int:id>', methods=['DELETE'])
def delete_diary(id):
    cur = mysql.connection.cursor()
    cur.execute('''DELETE FROM diary WHERE id = %s''', (id,))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Diary deleted successfully'})

#################Plano alimentar###############

@app.route('/meal_plan', methods=['GET'])
def get_meal_plan():
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM meal_plan''')
    meal_plan = cur.fetchall()
    cur.close()
    return jsonify(meal_plan)

@app.route('/meal_plan/<int:id>', methods=['GET'])
def get_meal_plan_by_id(id):
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM meal_plan WHERE id = %s''', (id,))
    meal_plan = cur.fetchall()
    cur.close()
    return jsonify(meal_plan)

@app.route('/meal_plan', methods=['POST'])
def add_meal_plan():
    cur = mysql.connection.cursor()
    title = request.json['title']
    quantity = request.json['quantity']
    meal = request.json['meal']
    cur.execute('''INSERT INTO meal_plan (title, quantity, meal ) VALUES (%s, %s)''', (title, quantity, meal))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'meal added successfully'})

@app.route('/meal_plan/<int:id>', methods=['PUT'])
def update_meal_plan(id):
    cur = mysql.connection.cursor()
    title = request.json['title']
    quantity = request.json['quantity']
    meal = request.json['meal']
    cur.execute('''UPDATE meal_plan SET title = %s, quantity = %s, meal= = %s  WHERE id = %s''', (title, quantity, meal))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Meal plan updated successfully'})

@app.route('/meal_plan/<int:id>', methods=['DELETE'])
def delete_meal_plan(id):
    cur = mysql.connection.cursor()
    cur.execute('''DELETE FROM meal_plan WHERE id = %s''', (id,))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'meal_plan deleted successfully'})

#################Informações nutricionais###############
@app.route('/nutritional_information', methods=['GET'])
def get_nutritional_information():
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM nutritional_information''')
    nutritional_information = cur.fetchall()
    cur.close()
    return jsonify(nutritional_information)

@app.route('/nutritional_information/<int:id>', methods=['GET'])
def get_nutritional_information_by_id(id):
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM nutritional_information WHERE id = %s''', (id,))
    nutritional_information = cur.fetchall()
    cur.close()
    return jsonify(nutritional_information)

@app.route('/nutritional_information', methods=['POST'])
def add_nutritional_information():
    cur = mysql.connection.cursor()
    title = request.json['title']
    specification = request.json['specification']
    description = request.json['description']
    kcal = request.json['kcal']
    image = request.json['image']
    category = request.json['category']
    cur.execute('''INSERT INTO nutritional_information (title,specification, description, kcal,image, is_in_diet, category) VALUES (%s, %s)''', (title, specification, description, kcal, image, category))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Nutritional information added successfully'})

@app.route('/nutritional_information/<int:id>', methods=['PUT'])
def update_nutritional_information(id):
    cur = mysql.connection.cursor()
    title = request.json['title']
    specification = request.json['specification']
    description = request.json['description']
    kcal = request.json['kcal']
    image = request.json['image']
    category = request.json['category']
    cur.execute('''UPDATE nutritional_information SET title = %s, specification = %s, description = %s, kcal = %s, image = %s, category = %s  WHERE id = %s''', (title, specification, description, kcal, image, category))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Nutritional information updated successfully'})

@app.route('/nutritional_information/<int:id>', methods=['DELETE'])
def delete_nutritional_information(id):
    cur = mysql.connection.cursor()
    cur.execute('''DELETE FROM nutritional_information WHERE id = %s''', (id,))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Nutritional information deleted successfully'})


#################Fale com um profissional###############
@app.route('/chat', methods=['GET'])
def get_chat():
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM chat''')
    chat = cur.fetchall()
    cur.close()
    return jsonify(chat)

@app.route('/chat/<int:id>', methods=['GET'])
def get_chat_by_id(id):
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM chat WHERE id = %s''', (id,))
    chat = cur.fetchall()
    cur.close()
    return jsonify(chat)

@app.route('/chat', methods=['POST'])
def add_chat():
    cur = mysql.connection.cursor()
    subject = request.json['subject']
    description = request.json['description']
    user_id = request.json['user_id']
    created_at = request.json['created_at']
    cur.execute('''INSERT INTO chat (subject,description, user_id, created_at) VALUES (%s, %s)''', (subject, description, user_id, created_at))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'chat information added successfully'})

@app.route('/chat/<int:id>', methods=['PUT'])
def update_chat(id):
    cur = mysql.connection.cursor()
    subject = request.json['subject']
    description = request.json['description']
    user_id = request.json['user_id']
    created_at = request.json['created_at']
    cur.execute('''UPDATE chat SET title = %s, specification = %s, description = %s, kcal = %s, image = %s, category = %s  WHERE id = %s''', (subject, description, user_id, created_at))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'chat information updated successfully'})

@app.route('/chat/<int:id>', methods=['DELETE'])
def delete_chat(id):
    cur = mysql.connection.cursor()
    cur.execute('''DELETE FROM chat WHERE id = %s''', (id,))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'chat information deleted successfully'})

#################Agendar uma consulta###############
@app.route('/appointment', methods=['GET'])
def get_appointment():
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM appointment''')
    appointment = cur.fetchall()
    cur.close()
    return jsonify(appointment)

@app.route('/appointment/<int:id>', methods=['GET'])
def get_appointment_by_id(id):
    cur = mysql.connection.cursor()
    cur.execute('''SELECT * FROM appointment WHERE id = %s''', (id,))
    appointment = cur.fetchall()
    cur.close()
    return jsonify(appointment)

@app.route('/appointment', methods=['POST'])
def add_appointment():
    cur = mysql.connection.cursor()
    professional_name = request.json['professional_name']
    date = request.json['date']
    time = request.json['time']
    user_id = request.json['user_id']
    cur.execute('''INSERT INTO appointment (professional_name, date, time, user_id) VALUES (%s, %s)''', (professional_name, date, time, user_id))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'appointmentinformation added successfully'})

@app.route('/appointment/<int:id>', methods=['PUT'])
def update_appointment(id):
    cur = mysql.connection.cursor()
    professional_name = request.json['professional_name']
    date = request.json['date']
    time = request.json['time']
    user_id = request.json['user_id']
    cur.execute('''UPDATE appointment SET professional_name = %s, date = %s, time = %s, kcal = %s, user_id = %s WHERE id = %s''', (professional_name, date, time, user_id))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'appointment updated successfully'})

@app.route('/appointment/<int:id>', methods=['DELETE'])
def delete_appointment(id):
    cur = mysql.connection.cursor()
    cur.execute('''DELETE FROM appointment WHERE id = %s''', (id,))
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'appointment deleted successfully'})

if __name__ == '__main__':
    app.run(debug=True)

