# Используем базовый образ Python с Node.js (чтобы не ставить Node отдельно)
FROM python:3.13-slim

# Устанавливаем uv и системные пакеты (включая Node.js для React)
RUN apt-get update && \
    apt-get install -y locales vim nano curl wget git sqlite3 tree && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    pip install uv && \
    npm install -g npm@latest && \
    rm -rf /var/lib/apt/lists/*

# Настраиваем локаль
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Копируем все из корня
WORKDIR /app
COPY . .

# Рабочая директория для бэкенда
WORKDIR /app/backend

# Создаём виртуальное окружение Python
RUN uv venv /venv 
ENV PATH="/venv/bin:${PATH}"

# Устанавливаем Python-зависимости
RUN uv pip install .

# Рабочая директория для фронтенда
WORKDIR /app/frontend

# Устанавливаем зависимости React
RUN npm install

# Собираем фронтенд
RUN npm run build

# Возвращаемся в корневую директорию
WORKDIR /app

# Для разработки (запускает FastAPI и React-сервер одновременно):
# CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port 8000 & cd /app/frontend && npm start"]

# Команда для входа в контейнер
CMD ["tail", "-f", "/dev/null"]
