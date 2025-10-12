import psycopg2
import psycopg2.extras
import os
from dotenv import load_dotenv

load_dotenv() 

def get_db_connection():
    conn = psycopg2.connect(
        host=os.getenv("DATABASE_HOST"),
        port=os.getenv("DATABASE_PORT", 5432),  # defaults to 5432 if not set
        database=os.getenv("DATABASE_NAME"),
        user=os.getenv("DATABASE_USER"),
        password=os.getenv("DATABASE_PASSWORD")
    )
    return conn