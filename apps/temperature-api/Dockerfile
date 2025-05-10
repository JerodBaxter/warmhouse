# Используйте базовый образ с Python
FROM python:3.11-slim

# Установите зависимости
WORKDIR /app
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Скопируйте код
COPY . .

# Укажите порт
EXPOSE 8081

# Запустите приложение
CMD ["python", "app.py"]
