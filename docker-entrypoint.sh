#!/bin/sh
set -e

# Note that this script is implemented in sh, *not* bash. This is to aid portability
# for environments which may have the minimal shell

# Command
# In order to deal with edge cases like requiring specific flags or filenames
# Look for an ENV and if present run the specified commands
if ! [ -z "${COMMAND}" ]; then
    eval ${COMMAND}
else

    # Python
    # Snyk requires Python to have downloaded the dependencies before running
    # If pip is present on the path, and we find a requirements.txt file, run pip install -r requirements.txt
    # If pipenv is present on the path, and we find a Pipfile without a Pipfile.lock, run pipenv update
    if [ -x "$(command -v pip)" ]; then
        if [ -f "requirements.txt" ]; then
            pip install -r requirements.txt
        fi
    fi

    if [ -f "Pipfile" ]; then
        if [ -x "$(command -v pip)" ]; then
            if ! [ -x "$(command -v pipenv)" ]; then
                pip install pipenv
            fi
            if [ -f "Pipfile.lock" ]; then
                pipenv sync
            else
                pipenv update
            fi
        fi
    fi

    # Maven
    # Snyk requires Maven to have downloaded the dependencies before running
    # If mvn is present on the path, and we find a pom.xml, run mvn install
    if [ -x "$(command -v mvn)" ]; then
        if [ -f "pom.xml" ]; then
            mvn install --no-transfer-progress
        fi
    fi
fi

exec $@
