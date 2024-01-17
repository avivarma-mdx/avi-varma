#!/usr/bin/env bash

cd /home/avi.varma/develop/tau

# Check if JAVA_HOME is set to temurin-11-jdk-amd64
if [[ "${JAVA_HOME}" != "/usr/lib/jvm/temurin-8-jdk-amd64" ]]; then
  # Set JAVA_HOME to temurin-11-jdk-amd64
  export JAVA_HOME="/usr/lib/jvm/temurin-8-jdk-amd64"
fi

export PATH=$JAVA_HOME/bin:$PATH

# Get the name of the current branch
# CURRENT_BRANCH=$(git branch --show-current)

# Get the name of the branch we want to be on
# TARGET_BRANCH="develop"

# If the current branch is not the target branch, perform a git checkout
# if [[ "${CURRENT_BRANCH}" != "${TARGET_BRANCH}" ]]; then
#   echo "Switching to branch ${TARGET_BRANCH}..."
#   git checkout ${TARGET_BRANCH}
# fi

# Build IPLM and start the interactive shell
. /home/avi.varma/develop/tau/all.bash
