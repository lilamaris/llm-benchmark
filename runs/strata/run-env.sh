#!/bin/sh
export STRATA_COMPONENTS_DIR=/home/lilamaris/workspace/benchmark/engines/strata/terminal/engine-feed
export STRATA_INSTALL_DIR=/home/lilamaris/workspace/benchmark/engines/strata/terminal
export STRATA_PROFILE_DIR=/home/lilamaris/workspace/benchmark/.state/strata/profiles
export STRATA_RUNTIME_DIR=/home/lilamaris/workspace/benchmark/.state/strata/runtime
export STRATA_SETTINGS_FILE=/home/lilamaris/workspace/benchmark/.state/strata/settings.json
export XDG_CONFIG_HOME=/home/lilamaris/workspace/benchmark/.state/config
export PYTHONUNBUFFERED=1
exec /home/lilamaris/workspace/benchmark/engines/strata/terminal/.venv/bin/python /home/lilamaris/workspace/benchmark/engines/strata/terminal/strata.py "$@"
