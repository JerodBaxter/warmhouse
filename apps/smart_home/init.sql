-- Создание базы данных, если она не существует
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM pg_database 
        WHERE datname = 'smarthome'
    ) THEN
        CREATE DATABASE smarthome;
    END IF;
END
$$;

-- Подключение к базе данных
\c smarthome;

-- Создание таблицы датчиков
CREATE TABLE IF NOT EXISTS sensors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL,
    value NUMERIC(10,2) DEFAULT 0,  -- Более точный тип для значений
    unit VARCHAR(20),
    status VARCHAR(20) NOT NULL DEFAULT 'inactive',
    last_updated TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Создание индексов для оптимизации запросов
CREATE INDEX IF NOT EXISTS idx_sensors_type 
ON sensors(type);

CREATE INDEX IF NOT EXISTS idx_sensors_location 
ON sensors(location);

CREATE INDEX IF NOT EXISTS idx_sensors_status 
ON sensors(status);

-- Добавление ограничений для статуса
ALTER TABLE sensors
ADD CONSTRAINT valid_status
CHECK (status IN ('active', 'inactive', 'error'));

-- Добавление триггера для обновления last_updated
CREATE OR REPLACE FUNCTION update_last_updated_column() 
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_updated = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_last_updated
BEFORE UPDATE ON sensors
FOR EACH ROW
EXECUTE FUNCTION update_last_updated_column();
