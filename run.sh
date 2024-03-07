#!/bin/bash

clear

# Check if the user is on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Error: This script only works on macOS."
    exit 1
fi

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    # Try to check if installed through Homebrew
    if command -v brew &> /dev/null; then
        if ! brew list | grep -q "imagemagick"; then
            echo "Error: ImageMagick is not installed. Please install it using Homebrew."
            exit 1
        fi
    else
        # Try to check if installed through MacPorts
        if ! port -v &> /dev/null; then
            echo "Error: ImageMagick is not installed. Please install it using Homebrew or MacPorts."
            exit 1
        elif ! port -qv installed imagemagick &> /dev/null; then
            echo "Error: ImageMagick is not installed. Please install it using MacPorts."
            exit 1
        fi
    fi
fi

# Execute create_icns.sh
./src/create_icns.sh
