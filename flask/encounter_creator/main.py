"""
Nathan Hurtig - 4/16/21
from https://flask.palletsprojects.com/en/1.1.x/tutorial/blog/
"""
import pyodbc
from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for, session
)
from werkzeug.exceptions import abort

from .auth import login_required
from .db import get_cursor

bp = Blueprint('main', __name__)


@bp.route('/', methods=['GET'])
@login_required
def index():
    return render_template('main/index.html')


@bp.route('/settings', methods=['GET'])
@login_required
def settings():
    book_array = None
    cursor = get_cursor()
    cursor.execute("DECLARE @STATUS SMALLINT "
                   "EXEC @STATUS = get_all_books @DMID_1=? "
                   "SELECT @STATUS AS Status", session['user_id'])
    try:
        book_array = cursor.fetchall()
        cursor.nextset()
        status = cursor.fetchval()
    except pyodbc.ProgrammingError:
        status = book_array[0][0]
    if status == 0:
        return render_template('main/settings.html', books=book_array)
    elif status == 1 or status == 2:
        print("Somehow, DM ID is bad? Logging out.")
        flash("Sorry, something went wrong on our end.")
        return redirect(url_for('auth.logout'))
    else:
        print("Unrecognized status code from get_all_books:", status)
        flash("Sorry, something went wrong on our end.")
        return redirect(url_for('main.index'))


@bp.route('/books', methods=['POST'])
@login_required
def save_books():
    book_array = None
    cursor = get_cursor()
    cursor.execute("DECLARE @STATUS SMALLINT "
                   "EXEC @STATUS = get_all_books @DMID_1=? "
                   "SELECT @STATUS AS Status", session['user_id'])
    try:
        book_array = cursor.fetchall()
        cursor.nextset()
        status = cursor.fetchval()
    except pyodbc.ProgrammingError:
        status = book_array[0][0]
    if status == 0:
        pass
    elif status == 1 or status == 2:
        print("Somehow, DM ID is bad? Logging out.")
        flash("Sorry, something went wrong on our end.")
        return redirect(url_for('auth.logout'))
    else:
        print("Unrecognized status code from get_all_books:", status)
        flash("Sorry, something went wrong on our end.")
        return redirect(url_for('main.index'))

    for book in book_array:
        found = False
        for book_id in request.form:
            if book.ID == int(book_id):
                found = True
                if book.Owned == 0:
                    # do something!
                    cursor.execute("DECLARE @STATUS SMALLINT "
                                   "EXEC @STATUS = update_book_owned @DMID_1=?, @BookID_2=?, @NewValue_3=? "
                                   "SELECT @STATUS AS Status", [session['user_id'], book.ID, 1])
                    status = cursor.fetchval()
                    if status == 0:
                        pass
                    elif status == 1 or status == 2:
                        print("Somehow, DM ID is bad? Logging out.")
                        flash("Sorry, something went wrong on our end.")
                        return redirect(url_for('auth.logout'))
                    elif status == 3 or status == 4:
                        print("There's a bug that's making the book ID bad for update_book_owned!")
                        flash("Sorry, something went wrong on our end.")
                        return redirect(url_for('main.settings'))
                    elif status == 5 or status == 6:
                        print("There's a bug that's making the new value bad for update_book_owned!")
                        flash("Sorry, something went wrong on our end.")
                        return redirect(url_for('main.settings'))
                    else:
                        print("Unrecognized error code from update_book_owned:", status)
                        flash("Sorry, something went wrong on our end.")
                        return redirect(url_for('main.settings'))
                break
        if not found and book.Owned == 1:
            cursor.execute("DECLARE @STATUS SMALLINT "
                           "EXEC @STATUS = update_book_owned @DMID_1=?, @BookID_2=?, @NewValue_3=? "
                           "SELECT @STATUS AS Status", [session['user_id'], book.ID, 0])
            status = cursor.fetchval()
            if status == 0:
                pass
            elif status == 1 or status == 2:
                print("Somehow, DM ID is bad? Logging out.")
                flash("Sorry, something went wrong on our end.")
                return redirect(url_for('auth.logout'))
            elif status == 3 or status == 4:
                print("There's a bug that's making the book ID bad for update_book_owned!")
                flash("Sorry, something went wrong on our end.")
                return redirect(url_for('main.settings'))
            elif status == 5 or status == 6:
                print("There's a bug that's making the new value bad for update_book_owned!")
                flash("Sorry, something went wrong on our end.")
                return redirect(url_for('main.settings'))
            else:
                print("Unrecognized error code from update_book_owned:", status)
                flash("Sorry, something went wrong on our end.")
                return redirect(url_for('main.settings'))

    cursor.commit()
    return redirect(url_for('main.settings'))
