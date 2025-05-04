from flask import Flask, request
import random

app = Flask(__name__)

@app.route('/temperature')
def get_temperature():
    location = request.args.get('location')
    sensor_id = request.args.get('sensor_id')
    
    # Обработка отсутствия location
    if not location:
        if sensor_id == '1':
            location = 'Living Room'
        elif sensor_id == '2':
            location = 'Bedroom'
        elif sensor_id == '3':
            location = 'Kitchen'
        else:
            location = 'Unknown'
    
    # Обработка отсутствия sensor_id
    if not sensor_id:
        if location == 'Living Room':
            sensor_id = '1'
        elif location == 'Bedroom':
            sensor_id = '2'
        elif location == 'Kitchen':
            sensor_id = '3'
        else:
            sensor_id = '0'
    
    # Генерация случайного значения температуры
    temperature = round(random.uniform(15, 30), 1)
    
    return {
        'location': location,
        'sensor_id': sensor_id,
        'temperature': temperature
    }

if __name__ == '__main__':
    app.run(port=8081)
