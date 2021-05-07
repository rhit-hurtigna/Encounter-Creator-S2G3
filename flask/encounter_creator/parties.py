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
from .helpers import alignment_code_to_string

bp = Blueprint('parties', __name__, url_prefix='/parties')


@bp.route('/', methods=['GET'])
@login_required
def parties():

    parties_list = []
    cursor = get_cursor()
    for row in g.user['parties']:
        party_id = row.ID
        name = row.name
        if party_id is None:
            print("Bad ID!")
            continue
        elif name is None:
            print("Bad name!")
            continue

        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = get_party_members @ID_1=? "
                       "SELECT @Status AS status", party_id)

        try:
            party = {'id': party_id, 'name': name, 'members': cursor.fetchall()}
            cursor.nextset()
            status = cursor.fetchval()
        except pyodbc.ProgrammingError:
            status = party['members'][0][0]

        if status == 0:
            parties_list.append(party)
        elif status == 1:
            print("Safety check for null ID in parties view should have triggered earlier!")
            continue
        elif status == 2:
            print("Party no longer exists!")
            continue
        else:
            print("Unknown error code for get_party_members:", status)
            continue

    return render_template('parties/index.html', parties=parties_list)


@bp.route('/member/<member_id>', methods=['GET'])
@login_required
def member(member_id):

    cursor = get_cursor()

    cursor.execute("DECLARE @Status SMALLINT "
                   "EXEC @Status = get_member_info @DMID_1=? , @MemberID_2=? "
                   "SELECT @Status AS status", session.get('user_id'), member_id)

    try:
        member_info = cursor.fetchone()
        long_alignment = alignment_code_to_string(member_info.Alignment, True)
        cursor.nextset()
        member_actions = cursor.fetchall()
        cursor.nextset()
        status = cursor.fetchval()
    except (pyodbc.ProgrammingError, AttributeError):
        status = member_info.status

    if status == 0:
        return render_template('parties/member.html', member=member_info, alignment=long_alignment, actions=member_actions)
    elif status == 1:
        print("Somehow, the DMID is null? Logging out")
        flash("Sorry, something went wrong on our end.")
        return redirect(url_for('auth.logout'))
    elif status == 2:
        print("Someone is trying to screw with our procedures!")
        flash("Sorry, something went wrong on our end.")
        return redirect(url_for('auth.logout'))
    elif status == 3 or status == 4 or status == 5:
        flash("Sorry, the requested member could not be found.")
        return redirect(url_for('parties.parties'))
    else:
        print("Unknown error code for get_member_info:", status)
        flash('Sorry, something went wrong on our end.')
        return redirect(url_for('parties.parties'))


@bp.route('/create', methods=['POST'])
@login_required
def create():
    name = request.form['name']
    error = None
    cursor = get_cursor()

    if not name:
        error = 'Party name is required.'
    elif len(name) > 30:
        error = 'Party name too long - maximum 30 characters.'

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
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 2:
            print("Someone is trying to screw with our procedures!")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 3:
            print("Safety check for null party name should have triggered earlier in party create view!")
            error = 'Party name is required.'
        elif status == 4:
            error = 'You already have a party of that name!'
        else:
            print("Unknown error code in create_party:", status)
            error = 'Server error - try again?'

    flash(error)
    return redirect(url_for('parties.parties'))


@bp.route('/edit', methods=['POST'])
@login_required
def edit():
    name = request.form['name']
    party_id = request.form['partyID']

    error = None
    cursor = get_cursor()

    if not name:
        error = 'Party name is required.'
    elif len(name) > 30:
        error = 'Party name too long - maximum 30 characters.'
    elif party_id == "":
        print("Was someone messing with the edit party form? Empty ID.")
        error = 'Sorry, something went wrong on our end.'

    if error is None:
        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = edit_party @DMID_1=?, @PartyID_2=?, @Name_3=? "
                       "SELECT @Status AS status",
                       session.get('user_id'), party_id, name)
        status = cursor.fetchval()

        if status == 0:
            cursor.commit()
            return redirect(url_for('parties.parties'))
        elif status == 1:
            print("Somehow, the DMID is null? Logging out")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 2:
            print("Someone is trying to screw with our procedures! DM ID does not exist!")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 3:
            print("Bad party ID!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 4:
            print("Nonexistent party!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 5:
            error = 'Party name is required.'
        elif status == 6:
            error = 'You already have a party of that name!'
        elif status == 7:
            print("Someone is trying to edit a party they don't own!")
            error = 'Sorry, something went wrong on our end.'
        else:
            print("Unknown error code in edit_party:", status)
            error = 'Server error - try again?'

    flash(error)
    return redirect(url_for('parties.parties'))


@bp.route('/delete', methods=['POST'])
@login_required
def delete():
    party_id = request.form['partyID']

    error = None
    cursor = get_cursor()

    if party_id == "":
        print("Was someone messing with the delete party form? Empty ID.")
        error = 'Sorry, something went wrong on our end.'

    if error is None:
        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = delete_party @DMID_1=?, @PartyID_2=? "
                       "SELECT @Status AS status",
                       session.get('user_id'), party_id)
        status = cursor.fetchval()

        if status == 0:
            cursor.commit()
            return redirect(url_for('parties.parties'))
        elif status == 1:
            print("Somehow, the DMID is null? Logging out")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 2:
            print("Someone is trying to screw with our procedures! DM ID does not exist!")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 3:
            print("Bad party ID!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 4:
            print("Nonexistent party!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 5:
            print("Someone is trying to delete a party they don't own!")
            error = 'Sorry, something went wrong on our end.'
        else:
            print("Unknown error code in delete_party:", status)
            error = 'Server error - try again?'

    flash(error)
    return redirect(url_for('parties.parties'))


@bp.route('/createMember', methods=['POST'])
@login_required
def create_member():
    name = request.form['name']
    level = int(request.form['level'])
    race = request.form['race']
    member_class = request.form['class']
    alignment = request.form['alignment']
    party_id = request.form['partyID']

    error = None

    if not name:
        error = 'Member name is required.'
    elif len(name) > 50:
        error = 'Member name too long - maximum 50 characters.'
    elif level < 1 or level > 20:
        error = 'Level must be between 1 and 20.'
    elif not race:
        error = 'Race is required.'
    elif not member_class:
        error = 'Class is required.'
    elif not alignment:
        error = 'Alignment is required.'

    if error is None:
        cursor = get_cursor()

        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = add_member @DMID_1=?, @PartyID_2=?, @Name_3=?, @Class_4=?, @Race_5=?, "
                       "@Alignment_6=?, @Level_7=? "
                       "SELECT @Status AS status",
                       session.get('user_id'), party_id, name, member_class, race, alignment, level)
        status = cursor.fetchval()

        if status == 0:
            cursor.commit()
            return redirect(url_for('parties.parties'))
        elif status == 1:
            print("Somehow, the DMID is null? Logging out")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 2:
            print("Someone is trying to screw with our procedures! DM ID does not exist!")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 3:
            print("Bad party ID!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 4:
            print("Nonexistent party!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 5:
            print("Someone is trying to edit a party they don't own!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 6:
            error = 'Member name is required.'
        elif status == 7:
            error = 'Member class is required.'
        elif status == 8:
            error = 'Member race is required.'
        elif status == 9 or status == 10:
            error = 'Invalid member alignment.'
        elif status == '11':
            error = 'Member level is required.'
        elif status == '12':
            error = 'Member level must be between 1 and 20.'
        else:
            print("Unknown error code from add_member:", status)
            error = 'Server error - try again?'

    flash(error)
    return redirect(url_for('parties.parties'))


@bp.route('/editMember', methods=['POST'])
@login_required
def edit_member():
    name = request.form['name']
    level = int(request.form['level'])
    race = request.form['race']
    member_class = request.form['class']
    alignment = request.form['alignment']
    member_id = request.form['memberID']

    error = None

    if len(name) > 50:
        error = 'Member name too long - maximum 50 characters.'
    elif level < 1 or level > 20:
        error = 'Level must be between 1 and 20.'

    if error is None:
        cursor = get_cursor()

        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = edit_member @DMID_1=?, @MemberID_2=?, @Name_3=?, @Class_4=?, @Race_5=?, "
                       "@Alignment_6=?, @Level_7=? "
                       "SELECT @Status AS status",
                       session.get('user_id'), member_id, name, member_class, race, alignment, level)
        status = cursor.fetchval()

        if status == 0:
            cursor.commit()
            return redirect(url_for('parties.member', member_id=member_id))
        elif status == 1:
            print("Somehow, the DMID is null? Logging out")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 2:
            print("Someone is trying to screw with our procedures! DM ID does not exist!")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 3:
            print("Bad member ID!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 4:
            print("Nonexistent member!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 5:
            print("Someone is trying to edit a member they don't own!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 6:
            error = 'Invalid member alignment.'
        elif status == '7':
            error = 'Member level must be between 1 and 20.'
        else:
            print("Unknown error code from edit_member:", status)
            error = 'Server error - try again?'

    flash(error)
    return redirect(url_for('parties.member', member_id=member_id))


@bp.route('/deleteMember', methods=['POST'])
@login_required
def delete_member():
    member_id = request.form['memberID']

    error = None
    cursor = get_cursor()

    if member_id == "":
        print("Was someone messing with the delete member form? Empty ID.")
        error = 'Sorry, something went wrong on our end.'

    if error is None:
        cursor.execute("DECLARE @Status SMALLINT "
                       "EXEC @Status = delete_member @DMID_1=?, @MemberID_2=? "
                       "SELECT @Status AS status",
                       session.get('user_id'), member_id)
        status = cursor.fetchval()

        if status == 0:
            cursor.commit()
            return redirect(url_for('parties.parties'))
        elif status == 1:
            print("Somehow, the DMID is null? Logging out")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 2:
            print("Someone is trying to screw with our procedures! DM ID does not exist!")
            flash("Sorry, something went wrong on our end.")
            return redirect(url_for('auth.logout'))
        elif status == 3:
            print("Bad member ID!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 4:
            print("Nonexistent member!")
            error = 'Sorry, something went wrong on our end.'
        elif status == 5:
            print("Someone is trying to delete a member they don't own!")
            error = 'Sorry, something went wrong on our end.'
        else:
            print("Unknown error code in delete_member:", status)
            error = 'Server error - try again?'

    flash(error)
    return redirect(url_for('parties.parties'))


@bp.route('/addAction', methods=['POST'])
@login_required
def add_action():
    pass