"""
WSGI config for mezza9 project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.10/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

from mezzanine.utils.conf import real_project_name

os.environ.setdefault("DJANGO_SETTINGS_MODULE",  "%s.settings" % real_project_name("mezza9"))

import sys

sys.path.append(os.path.dirname(os.path.abspath(__file__)) + '/..')

sys.path.append('C:/Users/Administrator/AppData/Local/Programs/Python/Python36/Lib/site-packages')

application = get_wsgi_application()
