#!/bin/bash
dir=$(pwd)

function head {
  printf ".:🥣 Agitare v0.1 - Scaffold an Project Tree..\n"
  echo " :flask-minimal (minimal)"
  echo " :flask-default (default)"
  echo " :flask-cookiecutter (dev)"
}

function make_flask() {
  opt="$1"
  # while getopts "h:minimal:default:dev:" opt; do
  case "${opt}" in
    -h)
      echo "Help function is given"
      echo "usage: $0 [-minimal] [-default] [-dev]"
      ;;
    -minimal)
      echo "Scafold some shit.."
      virtualenv env
      source env/bin/activate && pip install flask && pip install python-dotenv
      pip freeze > requirements.txt
      touch run.py config.py .env
      mkdir ${dir}/app
      mkdir ${dir}/app/templates && touch ${dir}/app/__init__.py ${dir}/app/views.py
      echo "$dir"
      tree -I 'env|list_build.txt|__pycache__'
      ;;
    -default)
      echo "still under development sorry :("
      ;;
    -dev)
      echo "still under development sorry :("
      ;;
    *)
      head
      echo " ~ usage: $0 [-h]"
      echo
      ;;
  esac
}

# main script
make_flask $1
