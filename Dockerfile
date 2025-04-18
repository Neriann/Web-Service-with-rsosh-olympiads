# Используем базовый образ Python с Node.js
FROM python:3.13-slim

# Устанавливаем системные пакеты (включая Node.js для React)
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

# Создаем пользователя appuser с динамическим UID/GID
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g ${GROUP_ID} appuser && \
    useradd -u ${USER_ID} -g appuser -d /app -s /bin/bash appuser && \
    mkdir -p /app && \
    chown appuser:appuser /app

# Копируем файлы с правильными правами
WORKDIR /app
COPY --chown=appuser:appuser . .

# Рабочая директория для бэкенда
WORKDIR /app/backend

# Создаём виртуальное окружение Python
RUN uv venv /venv && chown -R appuser:appuser /venv
ENV PATH="/venv/bin:${PATH}"

# Устанавливаем Python-зависимости
RUN uv pip install .

# Рабочая директория для фронтенда
WORKDIR /app/frontend

# Устанавливаем зависимости React и фиксим права
RUN npm install && \
    chown -R appuser:appuser /app/frontend/node_modules

# Собираем фронтенд
RUN npm run build && \
    chown -R appuser:appuser /app/frontend/build

# Возвращаемся в корневую директорию
WORKDIR /app

# Переключаемся на непривилегированного пользователя
USER appuser

# Команда для входа в контейнер
CMD ["tail", "-f", "/dev/null"]
