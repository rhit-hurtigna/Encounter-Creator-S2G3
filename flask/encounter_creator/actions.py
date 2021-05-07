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


@bp.route('/', methods=['GET'])
@login_required
def actions():
    pass
