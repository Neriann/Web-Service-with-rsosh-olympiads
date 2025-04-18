# Web-Service-with-rsosh-olympiads
Чтобы начать работу нужно последовательно выполнить данные команды:

создаем локальную копию репозитория
```bash
git clone https://github.com/Neriann/Web-Service-with-rsosh-olympiads.git
```

переименовываем рабочую директорию
```bash
mv Web-Service-with-rsosh-olympiads rsosh
```

создаем докер образ
```bash
cd rsosh
docker build \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) \
  -t rsosh-wrapper .
```

запускаем контейнер в фоновом режиме
```bash
docker run -d \
  --name rsosh-app \
  -p 8000:8000 \
  -v "$(pwd):/app" \
  rsosh-wrapper
```

заходим в контейнер в интерактивном режиме
```bash
docker exec -it rsosh-app bash
```

если не работают команды гита, нужно добавить конфиг
```bash
git config --global --add safe.directory /app
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

чтобы выйти из контейнера
```bash
exit
```

чтобы запустить проект пишем
```bash
uv run python main.py 
```
