"""
Nathan Hurtig - 4/15/21
Lots from https://flask.palletsprojects.com/en/1.1.x/tutorial/views/
"""
import functools
import hashlib
import uuid

from flask import Blueprint, flash, redirect, render_template, request, url_for, session, g

from .db import get_cursor

bp = Blueprint('auth', __name__, url_prefix='/auth')


@bp.route('/register', methods=('GET', 'POST'))
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cursor = get_cursor()
        error = None

        if not username:
            error = 'Username is required.'
        elif len(username) > 30:
            error = 'Username too long - maximum 30 characters.'
        elif not password:
            error = 'Password is required.'
        elif cursor.execute('SELECT ID FROM DM WHERE Username = ?', username).fetchone():
            error = 'Registration error.'

        if error is None:
            salt = uuid.uuid4().hex
            hashed_password = hashlib.sha512((password + salt).encode('utf-8')).hexdigest()
            cursor.execute(
                "DECLARE @Status SMALLINT "
                "EXEC @Status = add_user @Username_1 = ?, @Salt_2 = ?, @PasswordHash_3 = ? "
                "SELECT @Status AS status",
                (username, salt, hashed_password)
            )
            status = cursor.fetchone().status
            if status == 0:
                cursor.commit()
                return redirect(url_for('auth.login'))
            elif status == 1:
                print("Safety check for bad username should have triggered earlier in registration view!")
                error = 'Username is required.'
            elif status == 2:
                print("Safety check for taken username should have triggered earlier in registration view!")
                error = 'Registration error.'  # Username already taken
            elif status == 3:
                print("Error with salt function! Salt returned '", salt, "'")
                error = 'Registration error.'
            elif status == 4:
                print("Error in hashing! Hash function returned '", hashed_password, "'")
                error = 'Registration error.'
            else:
                print("Unknown error code in add_user:", status)
                error = 'Registration error.'

        flash(error)

    return render_template('auth/register.html')


@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cursor = get_cursor()
        error = None
        if not username:
            error = 'Username is required.'
        elif not password:
            error = 'Password is required.'
        elif not cursor.execute('SELECT id FROM DM WHERE Username = ?', username).fetchone():
            error = 'Login error.'

        if error is None:
            row = cursor.execute(
                "DECLARE @Status SMALLINT "
                "EXEC @Status = get_login_info @Username_1 = ? "
                "SELECT @Status AS status",
                username
            ).fetchone()
            cursor.nextset()
            status = cursor.fetchval()
            if status == 0:
                if hashlib.sha512((password + row.salt).encode('utf-8')).hexdigest() == row.hash:
                    session.clear()
                    session['user_id'] = row.ID
                    return redirect(url_for('index'))
                else:
                    error = 'Login error.'
            elif status == 1:
                print("Safety check for bad username should have been triggered earlier in login view!")
                error = 'Username is required.'
            elif status == 2:
                print("Safety check for nonexistent user should have been triggered earlier in login view!")
                error = 'Login error.'  # Username not already in table
            else:
                print("Unknown error code in get_login_info:", status)
                error = 'Login error.'

        flash(error)

    return render_template('auth/login.html')


@bp.before_app_request
def load_logged_in_user():
    user_id = session.get('user_id')

    if user_id is None:
        g.user = None

    else:
        g.user = {}
        cursor = get_cursor()

        if not cursor.execute('SELECT Username FROM DM WHERE ID = ?', user_id).fetchone():
            print("Somehow, we dropped a user mid-session!")
            session['user_id'] = None
            return redirect(url_for('auth.logout'))

        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = get_user_info @ID_1 = ? "
                       "SELECT @Status AS status", user_id)

        g.user['username'] = cursor.fetchval()
        cursor.nextset()
        g.user['parties'] = cursor.fetchall()
        cursor.nextset()
        g.user['books'] = cursor.fetchall()
        cursor.nextset()
        g.user['monsters'] = cursor.fetchall()
        cursor.nextset()
        g.user['types'] = cursor.fetchall()
        cursor.nextset()
        status = cursor.fetchval()
        if status == 0:
            return
        elif status == 1:
            print("Somehow while I thought the ID wasn't null, SQL Server did!")
        elif status == 2:
            print("Somehow even though I checked that the DM existed, SQL didn't find it!")

        session['user_id'] = None
        return redirect(url_for('auth.login'))


@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))


def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect(url_for('auth.login'))

        return view(**kwargs)

    return wrapped_view
