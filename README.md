# Web-Service-with-rsosh-olympiads
Чтобы начать работу нужно последовательно выполнить данные шаги:

Cоздаем локальную копию репозитория
```bash
git clone https://github.com/Neriann/Web-Service-with-rsosh-olympiads.git
```

Переименовываем рабочую директорию
```bash
mv Web-Service-with-rsosh-olympiads rsosh
```

Создаем докер образ
```bash
cd rsosh
docker build -t rsosh-wrapper
```

Запускаем контейнер в фоновом режиме
```bash
docker run -d --name rsosh-app -p 8000:8000 rsosh-wrapper
```

Заходим в контейнер в интерактивном режиме
```bash
docker exec -it rsosh-app bash
```

Чтобы выйти из контейнера пишем
```bash
exit
```

Когда мы в контейнере можем запустить наш вебсервис локально с помощью uvicorn:
```bash
uvicorn src.main:app --host 0.0.0.0 --port 8000
```
