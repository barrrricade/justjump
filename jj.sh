#!/bin/sh

#==================================
# Author: DesmondIp
# Date: 2025-07-28
# Description: A quick navigation tool
# for terminal that allows saving and
# jumping to directory locations using
# hotkeys
#==================================

# File to store the saved locations
LOCATIONS_FILE="$HOME/.jj_locations"

# Function to save a location
save_location() {
    local hotkey=$1
    local pth=$PWD
    
    # Create file if it doesn't exist
    touch "$LOCATIONS_FILE"
    
    # Remove existing hotkey if it exists
    sed -i '' "/^$hotkey:/d" "$LOCATIONS_FILE"
    
    # Save new location (strip any control characters)
    echo "$hotkey:$pth" | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' >> "$LOCATIONS_FILE"
    echo "Location saved: $hotkey -> $pth"
}

# Function to jump to a location
jump_location() {
    local hotkey=$1
    
    if [ ! -f "$LOCATIONS_FILE" ]; then
        echo "No saved locations found."
        return 1
    fi
    
    # Clean the file content and get location
    local location=$(sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' "$LOCATIONS_FILE" | grep "^$hotkey:" | cut -d':' -f2)
    
    if [ -z "$location" ]; then
        echo "Warning: No location saved for hotkey '$hotkey'"
        return 1
    fi
    
    # Strip any remaining control characters and change directory
    location=$(echo "$location" | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' | tr -d '\r')
    cd "$location"
    echo "Jumped to: $location"
}

# Function to clear all saved locations
clear_locations() {
    if [ -f "$LOCATIONS_FILE" ]; then
        /bin/rm "$LOCATIONS_FILE"
        echo "All saved locations cleared."
    else
        echo "No saved locations file exists."
    fi
}

# Function to list all saved locations
list_locations() {
    if [ ! -f "$LOCATIONS_FILE" ]; then
        echo "No saved locations found."
        return 1
    fi
    
    # Check if file is empty
    if [ ! -s "$LOCATIONS_FILE" ]; then
        echo "No saved locations. Use 'jj -s <hotkey>' to save locations."
        return 1
    fi

    # Use fzf to select a location and extract the path
    local selected=$(/bin/cat "$LOCATIONS_FILE" | fzf --prompt="Select location > ")
    if [ -n "$selected" ]; then
        local location=$(echo "$selected" | cut -d':' -f2)
        cd "$location"
        echo "Jumped to: $location"
    fi
}

# Function to show help
show_help() {
    echo "Usage: jj [option] [hotkey]"
    echo "Options:"
    echo "  <hotkey>           - Jump to saved location (default)"
    echo "  -j, --jump <hotkey>   - Jump to saved location"
    echo "  -s, --save <hotkey>   - Save current location to hotkey"
    echo "  -c, --clear          - Clear all saved locations"
    echo "  -l, --list           - List all saved locations (with fuzzy finder)"
    echo "  -h, --help           - Show this help message"
}

# Define the jj function
jj() {
    case "$1" in
        "-s"|"--save")
            if [ -z "$2" ]; then
                echo "Usage: jj -s <hotkey>"
                return 1
            fi
            save_location "$2"
            ;;
        "-j"|"--jump")
            if [ -z "$2" ]; then
                echo "Usage: jj -j <hotkey>"
                return 1
            fi
            jump_location "$2"
            ;;
        "-c"|"--clear")
            clear_locations
            ;;
        "-l"|"--list")
            list_locations
            ;;
        "-h"|"--help")
            show_help
            ;;
        "")
            list_locations
            ;;
        *)
            # If first argument exists but doesn't match any command, treat it as a jump hotkey
            jump_location "$1"
            ;;
    esac
}
