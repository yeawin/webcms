# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-07-15 01:48
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('musette', '0003_auto_20170714_2246'),
    ]

    operations = [
        migrations.RenameField(
            model_name='profile',
            old_name='ReceiveEmails',
            new_name='receive_emails',
        ),
    ]