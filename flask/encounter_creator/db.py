# Created by Nathan Hurtig, 4/15/21
# Using tutorial from https://flask.palletsprojects.com/en/1.1.x/tutorial/database/
# Also https://datatofish.com/how-to-connect-python-to-sql-server-using-pyodbc/
# And https://github.com/mkleehammer/pyodbc/wiki/Connecting-to-SQL-Server-from-Windows
from flask import g
import pyodbc


def init_app(app):
    app.teardown_appcontext(close_conn)


def get_cursor():
    if 'conn' not in g:
        g.conn = pyodbc.connect('Driver={ODBC Driver 17 for SQL Server};'
                                'Server=titan.csse.rose-hulman.edu;'
                                'Database=EncounterCreatorS2G3;'
                                'UID=EncounterCreatorAppAccount;PWD=YcOhgYfkzaPp!99Y#fEz;')
    return g.conn.cursor()


def close_conn(e=None):
    conn_to_close = g.pop('conn', None)

    if conn_to_close is not None:
        conn_to_close.close()
