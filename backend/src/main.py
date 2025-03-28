import uvicorn
from sqlalchemy import Session
from fastapi import FastAPI, Depends, Body
from fastapi.responses import JSONResponse, FileResponse

app = FastAPI()

# определяем зависимость
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/")
def main():
    return FileResponse("frontend/public/index.html")
