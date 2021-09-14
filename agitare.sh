#!/bin/bash
dir=$(pwd)

function head {
  printf "::🥣 Agitare v0.1 - Microscript to Scaffold Project Development ::\n"
  echo " .: Project: Agitare - https://github.com/rusagaib/agitare"
  echo " .: Author: @rusagaib"
  echo " .: Github: https://github.com/rusagaib"
  echo " .: [all-opt]: "
  echo "   --flask-minimal (minimal)"
  echo "   --flask-default (default)"
  echo "   --flask-api (Back-End REST API only)"
  # echo " : --flask-dev (fullstack flask with REST-API)"
  # echo " : --flask-cookiecutter (by coockiecutter all coverage, API routes etc)"
}

function make_flask() {
  opt="$1"
  # while getopts "h:minimal:default:dev:" opt; do
  case "${opt}" in
    -h)
      echo "::Help function is given.."
      echo ".:usage: $0 [--flask-minimal] [--flask-default] [--flask-api]"
      echo -e ".:use py environments: \n  ~\$ source env/bin/activate"
      echo -e ".:run: \n  ~\$ flask run"
      echo -e ".:exit: ctrl+c"
      echo -e ".:deactivate py env: \n  ~\$ deactivate"
      ;;
    --flask-minimal)
      echo "::Scafold some shit.."
      virtualenv env
      source env/bin/activate && pip install flask && pip install python-dotenv && pip install Flask-Migrate && pip install Flask-SQLAlchemy
      pip freeze > requirements.txt
      touch run.py config.py .env
      mkdir ${dir}/app
      mkdir ${dir}/app/templates && touch ${dir}/app/__init__.py ${dir}/app/views.py
      export FLASK_APP=run.py
      echo -e "\n\n📦 Build Finished.. \n"
      echo "$dir"
      tree -I 'env|list_build.txt|__pycache__'
      echo "\n📦 it's minimal as f*ck so yeah Happy Hacking!! and do as you like Cya~~\n\n"
      echo "📦 flask docs: https://flask.palletsprojects.com/en/2.0.x/"
      echo "📦 github: https://github.com/rusagaib"
      ;;
    --flask-default)
      # touch run.py config.py .env
      echo "::Scafold some shit.."
      virtualenv env
      source env/bin/activate && pip install flask && pip install python-dotenv && pip install Flask-Migrate && pip install Flask-SQLAlchemy
      pip freeze > requirements.txt
      mkdir ${dir}/app
      mkdir ${dir}/app/templates && touch ${dir}/app/models.py
      echo -e "import os\nfrom flask import Flask\nfrom flask_migrate import Migrate\nfrom flask_sqlalchemy import SQLAlchemy\nfrom flask_wtf.csrf import CSRFProtect\n\nfrom config import app_config\ndb = SQLAlchemy()\nmigrate = Migrate()\ncsrf = CSRFProtect()\n\ndef create_app(config_name):\n    app = Flask(__name__)\n    if os.getenv('FLASK_CONFIG') == \"development\":\n        app.config.from_object(app_config[config_name])\n        print(\"on development..\")\n    else:\n        app.config.from_object(app_config[config_name])\n        print(\"on\", str(os.getenv('FLASK_CONFIG')))\n    db.init_app(app)\n    migrate.init_app(app, db)\n    csrf.init_app(app)\n    # from app import models, routes\n    return app" > ${dir}/app/__init__.py
      echo -e "FLASK_APP = run.py\nFLASK_CONFIG = choose_\"development\"_or_\"production\"\nSECRET_KEY=its_super_secret\nDB_usr = username\nDB_pass = password\nDB_server = localhost\nDB_nm = db_name" > .env
      echo -e "from app import app\n@app.route('/')\n@app.route('/index')\ndef index():\n    return "Hello, World!"" > ${dir}/app/routes.py
      echo -e "import os\nfrom app import create_app\nconfig_name = os.getenv('FLASK_CONFIG')\napp = create_app(config_name)\nif __name__ == '__main__':\n    app.run(port=8000)" > run.py
      echo -e "import os\nfrom dotenv import load_dotenv\nbasedir = os.path.abspath(os.path.dirname(__file__))\nload_dotenv(os.path.join(basedir, '.env'))\nclass Config(object):\n    # Common configurations\n    # Put any configurations here that are common across all environments\n    FLASK_ENV=os.environ.get('FLASK_ENV')\n    SECRET_KEY = os.environ.get('SECRET_KEY')\n    FLASK_APP=os.environ.get('FLASK_APP')\n    SQLALCHEMY_TRACK_MODIFICATIONS = False\n    # WTF_CSRF_ENABLED = True\n\nclass DevelopmentConfig(Config):\n    # Development configurations\n    DEBUG = True\n    SQLALCHEMY_DATABASE_URI = \"sqlite:///\" + os.path.join(basedir, 'dev.db')\n    SQLALCHEMY_ECHO = True\n\nclass ProductionConfig(Config):\n    # Production configurations\n    DEBUG = False\n    SQLALCHEMY_DATABASE_URI = \"\"\n\napp_config = {'development': DevelopmentConfig,'production': ProductionConfig}" > config.py
      echo -e "\n\n📦 Build Finished.. \n"
      echo "$dir"
      tree -I 'env|list_build.txt|__pycache__'
      echo -e "\n\n📦 PLEASE EDIT/CONFIGURE .env File!!!"
      echo "📦 all feedback is a matter for us :) Happy Hacking!! Cya~~ "
      echo "📦 flask docs: https://flask.palletsprojects.com/en/2.0.x/"
      echo "📦 github: https://github.com/rusagaib"
      ;;
    --flask-api)
      echo "📦 well it's still under development sorry :("
      ;;
    *)
      head
      echo -e "\n~ usage: $0 [-h]"
      echo
      ;;
  esac
}

# main script
make_flask $1
