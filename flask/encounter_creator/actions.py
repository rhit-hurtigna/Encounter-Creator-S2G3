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
        print(actions_list)
        return render_template('actions/index.html', actions=actions_list, pageNum=page_num, maxPage=max_page)
    elif status == 1 or status == 2:
        pass
    else:
        print("Unknown error code for get_party_members:", status)

    return redirect(url_for('actions.actions', page_num=1))


@login_required
@bp.route('/create', methods=['POST'])
def create():
    name = request.form['name']
    description = request.form['description']
    error = None
    cursor = get_cursor()

    if not name:
        error = 'Action name is required.'
    elif len(name) > 50:
        error = 'Action name too long - maximum 50 characters.'
    elif not description:
        error = 'Action description is required.'
    elif len(description) > 200:
        error = 'Action description too long - maximum 200 characters.'

    if error is None:
        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = create_action @Name=?, @Description=? "
                       "SELECT @Status AS status",
                       name, description)
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
