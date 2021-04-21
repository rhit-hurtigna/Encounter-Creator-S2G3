"""
Nathan Hurtig - 4/16/21
from https://flask.palletsprojects.com/en/1.1.x/tutorial/blog/
"""
from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort

from .auth import login_required
from .db import get_cursor

bp = Blueprint('monsters', __name__, url_prefix='/monsters')


@bp.route('/', methods=('GET', 'POST'))
@login_required
def monsters():
    return render_template('monsters/index.html', monsters=monsters)
