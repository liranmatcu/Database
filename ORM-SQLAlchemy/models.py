"""SQLAlchemy Data Models."""
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column
from sqlalchemy.types import Integer, Text, String, DateTime
from sqlalchemy.sql import func
from database import engine

Base = declarative_base()

class User(Base):
    """User account."""

    __tablename__ = "user"

    id = Column(Integer, primary_key=True, autoincrement="auto")
    username = Column(String(255), unique=True, nullable=False)
    password = Column(Text, nullable=False)
    email = Column(String(255), unique=True, nullable=False)
    first_name = Column(String(255))
    last_name = Column(String(255))
    bio = Column(Text)
    avatar_url = Column(Text)
    created_at = Column(DateTime, server_default=func.now())
    updated_at = Column(DateTime, server_default=func.now())

    def __repr__(self):
        return f"<User {self.username}>"


Base.metadata.create_all(engine)

