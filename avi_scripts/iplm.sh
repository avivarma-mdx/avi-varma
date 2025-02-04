#!/usr/bin/env bash

cd /home/avi.varma/develop/tau

# Function to check if JDK 11 is installed and set JAVA_HOME
set_java_home_to_jdk11() {
    echo "Checking for JDK 11 installation..."

    # Get the list of Java alternatives
    java_list=$(update-alternatives --list java)

    # Check if JDK 11 is in the list
    jdk11_path=""
    for java_path in $java_list; do
        if [[ $java_path == *"temurin-11"* ]]; then
            jdk11_path=$java_path
            break
        fi
    done

    # If JDK 11 is found, set JAVA_HOME
    if [ -n "$jdk11_path" ]; then
        export JAVA_HOME=$(dirname $(dirname $jdk11_path))
        echo "JDK 11 found at: $jdk11_path"
        echo "JAVA_HOME set to: $JAVA_HOME"
        export PATH=$JAVA_HOME/bin:$PATH
        echo "JAVA_HOME appended to PATH..."
    else
        echo "ERROR: JDK 11 not found."
        exit 1
    fi
}

build_server() {
    cd /home/avi.varma/develop/tau/iplm
    ./gradlew clean
    ./gradlew :piserver-application:installDist
}

clean_venv() {
    cd /home/avi.varma/develop/tau
    rm -rf venv
}

# Build IPLM and start the interactive shell
set_java_home_to_jdk11
. /home/avi.varma/develop/tau/all.bash

# Check if the "--build" flag is provided
if [[ "$1" == "--build" ]]; then
    build_server
fi

echo "Changing directory to ~/develop/tau/"
cd ~/develop/tau/
