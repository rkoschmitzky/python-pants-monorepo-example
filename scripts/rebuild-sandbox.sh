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
cd "$(git rev-parse --show-toplevel)" || { echo "Failure"; exit 1; }

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
echo "$(which python)"

python -m pip install --upgrade -r pip-requirements.txt
python -m pip install -r dev-requirements.txt -r requirements.txt
