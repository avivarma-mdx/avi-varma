#!/usr/bin/env bash

# Global variable to store the chosen path
CHOSEN_PATH=""

# Function to prompt user for path selection
select_path() {
    echo "Select path option:"
    echo "1) LEGACY"
    echo "2) IPLM"
    read -p "Enter option (1 or 2): " option

    case $option in
        1)
            echo "You selected LEGACY."
            CHOSEN_PATH="/home/avi.varma/develop/LEGACY/tau/"
            # Change directory to the chosen path
            cd "$CHOSEN_PATH" || { echo "ERROR: Failed to change directory to $CHOSEN_PATH"; exit 1;}
            set_java_home_to_jdk8
            . all.bash
            ;;
        2)
            echo "You selected IPLM."
            CHOSEN_PATH="/home/avi.varma/develop/IPLM/tau/"
            # Change directory to the chosen path
            cd "$CHOSEN_PATH" || { echo "ERROR: Failed to change directory to $CHOSEN_PATH"; exit 1;}
            set_java_home_to_jdk11
            cd iplm && ./gradlew :piserver-application:installDist
            ;;
        *)
            echo "Invalid option. Please run the script again and select 1 or 2."
            exit 1
            ;;
    esac
}

# Function to check if JDK 8 is installed and set JAVA_HOME
set_java_home_to_jdk8() {
    echo "Checking for JDK 8 installation..."

    # Get the list of Java alternatives
    java_list=$(update-alternatives --list java)

    # Check if JDK 8 is in the list
    jdk8_path=""
    for java_path in $java_list; do
        if [[ $java_path == *"temurin-8-jdk"* ]]; then
            jdk8_path=$java_path
            break
        fi
    done

    # If JDK 8 is found, set JAVA_HOME
    if [ -n "$jdk8_path" ]; then
        export JAVA_HOME=$(dirname $(dirname $jdk8_path))
        echo "JDK 8 found at: $jdk8_path"
        echo "JAVA_HOME set to: $JAVA_HOME"
        export PATH=$JAVA_HOME/bin:$PATH
        echo "JAVA_HOME appended to PATH..."
    else
        echo "ERROR: JDK 8 not found."
        exit 1
    fi
}

set_java_home_to_jdk11() {
    echo "Checking for JDK 11 installation..."

    # Get the list of Java alternatives
    java_list=$(update-alternatives --list java)

    # Check if JDK 11 is in the list
    jdk11_path=""
    for java_path in $java_list; do
        if [[ $java_path == *"temurin-11-jdk"* ]]; then
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

# Prompt user to select path
select_path
