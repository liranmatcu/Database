from models import User
from database import session


user = User(
    username="admin",
    password="safe",
    email="admin@example.com",
    first_name="Anna",
    last_name="Payne",
    bio="TCU Super Frog",
    avatar_url="https://example.com/avatar.jpg"
)

session.add(user)  # Add the user
session.commit()  # Commit the change