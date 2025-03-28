from sqlalchemy import create_engine, Column, String
from sqlalchemy.orm import DeclarativeBase, sessionmarker


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

SessionLocal = sessionmaker(autoflush=False, bind=engine)
