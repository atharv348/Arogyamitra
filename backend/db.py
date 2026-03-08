from services.auth import get_password_hash

# In-memory user database
fake_users_db = {
    "admin": {
        "username": "admin",
        "full_name": "Admin User",
        "email": "admin@arogyamitra.com",
        "hashed_password": get_password_hash("admin123"),
    },
    "johndoe": {
        "username": "johndoe",
        "full_name": "John Doe",
        "email": "johndoe@example.com",
        "hashed_password": get_password_hash("secret"),
    }
}

def get_user(username: str):
    if username in fake_users_db:
        return fake_users_db[username]
