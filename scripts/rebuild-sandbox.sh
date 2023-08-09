#!/usr/bin/env bash
#
# Builds (or rebuilds) the sandbox of a library. Run as:
#
# ./$(git rev-parse --show-toplevel)/scripts/rebuilds-sandbox.sh
#
# in any library directory. You likely want to source the sandbox in your
# shell after having called this script. Do it with:
#
# source .venv/bin/activate

set -x

# jump to project root
project_root="$(git rev-parse --show-toplevel)" || { echo "Failure"; exit 1; }
cd "$project_root"

# re-init virtual env
rm -Rf ".venv"
python3 -m venv .venv

# Conditional block for Linux
if [ "$(uname -s)" = "Linux" ]; then
    source .venv/bin/activate
else
    # we are likely on windows
    source .venv/Scripts/activate
fi

# verify that we are using the inpreteter from our virtual env
which python

python -m pip install --upgrade -r pip-requirements.txt
python -m pip install poetry

export POETRY_VIRTUALENVS_CREATE=0
export POETRY_VIRTUALENVS_PATH="$project_root/.venv"
export POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON=1

poetry install --no-root --no-cache -v
