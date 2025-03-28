# Используем базовый образ Python
FROM python:3.13-slim

# Устанавливаем uv и дополнительные системные пакеты
RUN pip install uv && apt-get update && apt-get install -y locales vim nano curl wget git sqlite3

# Устнавливаем нужную кодировку
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Создаём виртуальное окружение
RUN uv venv /venv

# Активируем виртуальное окружение
ENV PATH="/venv/bin:${PATH}"

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы зависимостей
COPY pyproject.toml uv.lock ./

# Устанавливаем зависимости с помощью uv
RUN uv pip install .

# Копируем исходный код
COPY . .

# Команда для входа в контейнер
CMD ["tail", "-f", "/dev/null"]
