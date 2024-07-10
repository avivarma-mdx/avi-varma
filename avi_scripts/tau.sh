#!/usr/bin/env bash

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

# Function to show help message
show_help() {
    echo "Usage: $0 [--recompile] [--help]"
    echo ""
    echo "Options:"
    echo "  --recompile   Run the recomp command after setting up the environment."
    echo "  --help        Show this help message."
    exit 0
}

# Parse command line arguments
recompile_flag=false
for arg in "$@"; do
    case $arg in
        --recompile)
        recompile_flag=true
        shift
        ;;
        --help)
        show_help
        ;;
        *)
        echo "Unknown option: $arg"
        show_help
        ;;
    esac
done

# Build IPLM and start the interactive shell
echo "WARNING: BUILDING LEGACY - DEPRICATED..."
set_java_home_to_jdk8
cd ~/develop/tau/
. all.bash

# Run js if the recompile flag is set
if [ "$recompile_flag" = true ]; then
    js
fi
