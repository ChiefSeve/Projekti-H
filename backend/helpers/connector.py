import mysql.connector
from dotenv import load_dotenv
import os

load_dotenv()


class Database:
    def __init__(self):
        self.conn = mysql.connector.connect(
            host=os.getenv('DB_HOST'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASSWORD'),
            database=os.getenv('DB_DATABASE'),
            port=3306,
            autocommit=True
        )

    def get_conn(self):
        return self.conn


mydb = Database()
