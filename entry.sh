#!/bin/bash
cd statuspage/
service postgresql start && sh -c 'python3 -m venv venv' && sh -c 'python3 manage.py runserver 0.0.0.0:8000 --insecure'
