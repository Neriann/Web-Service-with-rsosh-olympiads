import uvicorn
from fastapi import FastAPI
from sqlalchemy import create_engine
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy import  Column, String


SQLALCHEMY_DATABASE_URL = "sqlite:///./sql_app.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)

class Base(DeclarativeBase): pass

class User(Base):
    __tablename__ = "users"

    email = Column(String, primary_key=True)
    password = Column(String)
    username = Column(String)

Base.metadata.create_all(bind=engine)

app = FastAPI()

#@app.get("/")
#def read_root():
#    return {"message": "Hello from FastAPI!"}

#@app.get("/items/{item_id}")
#def read_item(item_id: int, q: str = None):
#    return {"item_id": item_id, "q": q}

#if __name__ == "__main__":
 #   uvicorn.run(app, host="0.0.0.0", port=8000)
