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
        has_next = cursor.fetchval()
        cursor.nextset()
        status = cursor.fetchval()
    except pyodbc.ProgrammingError:
        status = actions_list[0][0]
    if status == 0:
        print(actions_list)
        return render_template('actions/index.html', actions=actions_list, hasNext=has_next)
    elif status == 1 or status == 2:
        pass
    else:
        print("Unknown error code for get_party_members:", status)

    return redirect(url_for('parties.parties'))


@login_required
@bp.route('/create', methods=['POST'])
def create():
    pass
