#!/usr/bin/python
import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,"/var/www/Encounter-Creator-S2G3/flask")

from encounter_creator import create_app
application = create_app()
