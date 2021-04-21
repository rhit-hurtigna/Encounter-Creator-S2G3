"""
Nathan Hurtig - 4/16/21
from https://flask.palletsprojects.com/en/1.1.x/tutorial/blog/
"""
from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for, session
)
from werkzeug.exceptions import abort

from .auth import login_required
from .db import get_cursor

bp = Blueprint('parties', __name__, url_prefix='/parties')


@bp.route('/', methods=('GET', 'POST'))
@login_required
def parties():
    if request.method == 'POST':
        pass

    parties_list = []
    cursor = get_cursor()
    for row in g.user['parties']:
        print(row.cursor_description)
        party_id = row.ID
        name = row.name
        if party_id is None:
            print("Bad ID!")
            continue
        elif name is None:
            print("Bad name!")
            continue
        elif not cursor.execute("SELECT ID FROM PARTY WHERE ID = ?", party_id).fetchval():
            print("Non-existent party!")
            continue

        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = get_party_members @ID_1=? "
                       "SELECT @Status AS status", party_id)

        party = {'id': party_id, 'name': name, 'members': cursor.fetchall()}
        cursor.nextset()
        status = cursor.fetchval()

        if status == 0:
            parties_list.append(party)
        elif status == 1:
            print("Safety check for null ID in parties view should have triggered earlier!")
            continue
        elif status == 2:
            print("Safety check for nonexistent table should have triggered earlier!")
            continue
        else:
            print("Unknown error code for get_party_members:", status)
            continue

    return render_template('parties/index.html', parties=parties_list)


@bp.route('/create', methods=('GET', 'POST'))
@login_required
def create():
    if request.method == 'POST':
        name = request.form['name']
        error = None
        cursor = get_cursor()

        if not name:
            error = 'Party name is required.'
        elif len(name) > 30:
            error = 'Party name too long - maximum 30 characters.'
        elif not cursor.execute("SELECT ID FROM DM WHERE ID = ?", session.get('user_id')).fetchone():
            print("Somehow we dropped the DM from the table mid-session?")
            return redirect(url_for('auth.logout'))

        if error is None:
            cursor.execute("DECLARE @Status SMALLINT "
                           "EXEC @Status = create_party @ID_1=?, @Name_2=? "
                           "SELECT @Status AS status",
                           session.get('user_id'), name)
            status = cursor.fetchval()

            if status == 0:
                cursor.commit()
                return redirect(url_for('parties.parties'))
            elif status == 1:
                print("Somehow, the DMID is null? Logging out")
                return redirect(url_for('auth.logout'))
            elif status == 2:
                print("Safety check for nonexistent DM should have triggered earlier in party create view!")
                return redirect(url_for('auth.logout'))
            elif status == 3:
                print("Safety check for null party name should have triggered earlier in party create view!")
                error = 'Party name is required.'
            else:
                print("Unknown error code in create_party:", status)
                error = 'Server error - try again?'

        flash(error)

    return render_template('parties/create.html')
