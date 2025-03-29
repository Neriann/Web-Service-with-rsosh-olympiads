# Web-Service-with-rsosh-olympiads
Чтобы начать работу нужно последовательно выполнить данные команды:
```bash
git clone https://github.com/Neriann/Web-Service-with-rsosh-olympiads.git # создаем локальную копию репозитория
```

```bash
mv Web-Service-with-rsosh-olympiads rsosh # переименовываем рабочую директорию
```

```bash
cd rsosh
docker build -t rsosh-wrapper . # создаем докер образ
```

```bash
docker run -d --name rsosh-app -p 8000:8000 rsosh-wrapper # запускаем контейнер в фоновом режиме
```

```bash
docker exec -it rsosh-app bash # заходим в контейнер в интерактивном режиме
```

```bash
exit # чтобы выйти из контейнера
```

Чтобы запустить проект пишем
```bash
uv run python main.py 
```
