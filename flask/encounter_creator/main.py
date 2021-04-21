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

bp = Blueprint('main', __name__)


@bp.route('/', methods=['GET'])
@login_required
def index():
    return render_template('main/index.html')


@bp.route('/settings', methods=('GET', 'POST'))
@login_required
def settings():
    return render_template('main/settings.html')
