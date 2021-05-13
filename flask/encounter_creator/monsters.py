"""
Jackson Hajer - 5/6/21
from https://flask.palletsprojects.com/en/1.1.x/tutorial/blog/
"""
import pyodbc
from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for, session
)
from werkzeug.exceptions import abort

from .auth import login_required
from .db import get_cursor

bp = Blueprint('monsters', __name__, url_prefix='/monsters')


@bp.route('/', methods=['GET'])
def monsters():
    cursor = get_cursor()

    cursor.execute("DECLARE @status SMALLINT EXEC @status = get_monster_info @DMID = ? SELECT @status AS status",
                   session.get('user_id'))

    try:
        monsters_list = cursor.fetchall()
        status = cursor.fetchval()
    except pyodbc.ProgrammingError:
        status = 1
        print('hi, bad things happened')

    return render_template('monsters/index.html', monsters=monsters_list)


@bp.route('/create', methods=['POST'])
@login_required
def create():
    name = request.form['name']
    cr = request.form['cr']
    type_name = request.form['type']
    book_name = request.form['book']
    alignment = request.form['alignment']

    error = None
    cursor = get_cursor()

    args = [name, cr]
    query_str = 'DECLARE @status SMALLINT EXEC @status = create_monster @monst_name= ?, @CR= ?,'

    if type_name != '':
        args.append(type_name)
        query_str = query_str + '@type_name = ?,'

    if book_name != '':
        args.append(book_name)
        query_str = query_str + '@book_name = ?,'

    if alignment != '':
        args.append(alignment)
        query_str = query_str + '@align = ?,'

    query_str = query_str[:-1]
    query_str = query_str + ' SELECT @status AS status'

    cursor.execute(query_str, args)
    status = cursor.fetchval()

    if status == 0:
        print('hi')
        cursor.commit()
        return redirect(url_for('monsters.monsters'))
    elif status == 1:
        print("Somehow, the MonsterID is null? Logging out")
        flash("Sorry, something went wrong on our end.")
        return redirect(url_for('auth.logout'))
    elif status == 2:
        print("Someone is trying to screw with our procedures!")
        flash("Sorry, something went wrong on our end.")
        return redirect(url_for('auth.logout'))
    elif status == 3:
        print("Safety check for null monster name should have triggered earlier in monster create view!")
        error = 'Monster name is required.'
    elif status == 4:
        error = 'There is already a monster of that name!'
    else:
        print("Unknown error code in create_monster:", status)
        error = 'Server error - try again?'
    flash(error)
    return redirect(url_for('monsters.create'))


@bp.route('/search', methods=['GET', 'POST'])
@login_required
def search():
    query = request.args['search']
    if query == None or query == '':
        return redirect(url_for('monsters.monsters'))
    return redirect(url_for('monsters.searchView', name=query))


@bp.route('/search/<name>', methods=['GET', 'POST'])
def searchView(name):
    cursor = get_cursor()

    cursor.execute("DECLARE @status SMALLINT EXEC @status = get_monster_info @name = ? SELECT @status AS status", name)
    print(name)
    try:
        monsters_list = cursor.fetchall()
        status = cursor.fetchval()
    except pyodbc.ProgrammingError:
        status = 1
        print('hi, bad things happened')

    return render_template('monsters/index.html', monsters=monsters_list)


@bp.route('/delete', methods=['POST'])
def delete():
    name = request.form['name']

    error = None
    cursor = get_cursor()

    cursor.execute("DECLARE @status SMALLINT "
                   "EXEC @status = delete_monster @monst_name = ? "
                   "SELECT @status AS status", name)
    status = cursor.fetchval()

    if status == 0:
        cursor.commit()
        return redirect(url_for('monsters.monsters'))
    elif status == 1:
        print("Name cannot be null or empty.")
        flash("Cannot delete an empty name")
        return redirect(url_for('monsters.delete'))
    elif status == 2:
        print("Monster does not exist.")
        flash("Cannot delete, monster doesn't exist")
        return redirect(url_for('monsters.delete'))
    else:
        print("Unknown error code in delete_party:", status)
        error = 'Server error - try again?'

    flash(error)
    return redirect(url_for('monsters.delete'))


@bp.route('/edit', methods=['POST'])
def edit():
    name = request.form['name']
    new_name = request.form['newName']
    cr = request.form['cr']
    type_name = request.form['type']
    book_name = request.form['book']
    alignment = request.form['alignment']

    error = None
    cursor = get_cursor()

    args = [name]
    query_str = "DECLARE @status SMALLINT EXEC @status = update_monster @monst_name= ?,"

    if new_name != '':
        args.append(new_name)
        query_str = query_str + '@new_name = ?,'

    if cr != '':
        args.append(cr)
        query_str = query_str + '@CR = ?,'

    if type_name != '':
        args.append(type_name)
        query_str = query_str + '@type_name = ?,'

    if book_name != '':
        args.append(book_name)
        query_str = query_str + '@book_name = ?,'

    if alignment != '':
        args.append(alignment)
        query_str = query_str + '@align = ?,'

    query_str = query_str[:-1]
    query_str = query_str + ' SELECT @status AS status'
    print(query_str)
    cursor.execute(query_str, args)
    status = cursor.fetchval()

    # TODO: add error checking
    cursor.commit()
    return redirect(url_for('monsters.monsters'))

    flash(error)
    return redirect(url_for('monsters.monsters'))


@bp.route('/toggle', methods=['POST'])
@login_required
def toggle_liked():
    cursor = get_cursor()
    monster_id = request.form.get('monster_id', None)
    error = None
    if not monster_id or monster_id < 0:
        error = 'Sorry, something went wrong on our end.'

    if error is not None:
        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC toggle_monster_liked @DMID_1=?, @MonsterID_2=? "
                       "SELECT @Status AS status", session.get('user_id'), monster_id)
        status = cursor.fetchval()
        if status == 0:
            cursor.commit()
            return redirect(url_for('monsters.monsters'))
        elif status == 1:
            print("Somehow, DMID is bad! Logging out.")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 2:
            error = "Sorry, something went wrong on our end."
        else:
            print("Unrecognized return code for toggle_monster_liked:", status)
            error = "Sorry, something went wrong on our end."
    flash(error)
    return redirect(url_for('monsters.monsters'))
