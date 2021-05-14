"""
Nathan Hurtig - 5/06/21
from https://flask.palletsprojects.com/en/1.1.x/tutorial/blog/
"""
import pyodbc
from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for, session
)
from werkzeug.exceptions import abort

from .auth import login_required
from .db import get_cursor
from .helpers import alignment_code_to_string

bp = Blueprint('actions', __name__, url_prefix='/actions')


@bp.route('/<int:page_num>', methods=['GET'])
def actions(page_num):

    actions_list = []
    cursor = get_cursor()

    cursor.execute("DECLARE @Status SMALLINT "
                   "EXEC @Status = get_actions @Page_1=? "
                   "SELECT @Status AS status", page_num)

    try:
        actions_list = cursor.fetchall()
        cursor.nextset()
        max_page = cursor.fetchval()
        cursor.nextset()
        status = cursor.fetchval()
    except pyodbc.ProgrammingError:
        status = actions_list[0][0]
    if status == 0:
        return render_template('actions/index.html', actions=actions_list, pageNum=page_num, maxPage=max_page)
    elif status == 1 or status == 2:
        pass
    else:
        print("Unknown error code for get_actions:", status)

    flash("Sorry, something went wrong on our end.")
    return redirect(url_for('actions.actions', page_num=1))


@bp.route('search/', methods=['GET'])
def search():

    actions_list = []
    cursor = get_cursor()
    query = request.args.get('search', '').strip()
    if len(query) < 3:
        flash("Sorry, you must search by at least 3 characters.")
        return redirect(url_for('actions.actions', page_num=1))
    elif len(query) > 50:
        flash("Sorry, you must search by at most 50 characters.")
        return redirect(url_for('actions.actions', page_num=1))

    cursor.execute("DECLARE @Status SMALLINT "
                   "EXEC @Status = search_actions @Search_1=? "
                   "SELECT @Status AS status", query)

    try:
        actions_list = cursor.fetchall()
        cursor.nextset()
        status = cursor.fetchval()
    except pyodbc.ProgrammingError:
        status = actions_list[0][0]
    if status == 0:
        return render_template('actions/index.html', actions=actions_list, pageNum=1, maxPage=1)
    elif status == 1:
        print("Check for bad query should have triggered earlier in action search!")
        error = "Sorry, you must search by at least 3 characters."
    else:
        print("Unknown error code for search_actions:", status)
        error = "Sorry, something went wrong on our end."

    flash()
    return redirect(url_for('actions.actions', page_num=1))


@login_required
@bp.route('/create', methods=['POST'])
def create():
    name = request.form['name']
    error = None
    cursor = get_cursor()

    if not name:
        error = 'Action name is required.'
    elif len(name) > 50:
        error = 'Action name too long - maximum 50 characters.'

    if error is None:
        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = create_action @Name=? "
                       "SELECT @Status AS status",
                       name)
        status = cursor.fetchval()

        if status == 0:
            cursor.commit()
            return redirect(url_for('actions.actions', page_num=1))
        elif status == 1:
            print("Safety check for bad name should have triggered earlier in create action view!")
            error = "Sorry, something went wrong on our end."
        elif status == 2:
            error = "Sorry, an action with the same name already exists."
        else:
            print("Unknown error code in create_party:", status)
            error = 'Server error - try again?'

    flash(error)
    return redirect(url_for('actions.actions', page_num=1))
