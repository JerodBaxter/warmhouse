# Базовый образ
FROM python:3.11-slim

# Установка зависимостей
RUN pip install --upgrade pip

# Копирование файлов
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

# Экспозиция порта
EXPOSE 8081

# Запуск приложения
CMD ["python", "app.py"]
