#!/bin/bash

# Find the desired Google Chrome executable
# Using specific paths to avoid scanning entire /
find_result=$(find /usr/bin /opt /snap -type f -name "google-chrome" 2>/dev/null | grep -v "test" | head -n 1)

# If not found in common places, try a broader search but exclude huge dirs if possible, or stick to user logic
if [[ -z $find_result ]]; then
    find_result=$(find / -type f -name "google-chrome" 2>/dev/null | grep "extra/google-chrome" | head -n 1)
fi

# Check if the find_result is not empty
if [[ -n $find_result ]]; then
    # Update or add the CHROME_EXECUTABLE line in ~/.bashrc
    if grep -q "^export CHROME_EXECUTABLE=" ~/.bashrc; then
        # Update the existing line
        sed -i "s|^export CHROME_EXECUTABLE=.*|export CHROME_EXECUTABLE=$find_result|" ~/.bashrc
    else
        # Add a new line if it doesn't exist
        echo "export CHROME_EXECUTABLE=$find_result" >> ~/.bashrc
    fi

    echo "Found Chrome at: $find_result"
    echo "CHROME_EXECUTABLE updated in ~/.bashrc."
else
    echo "Google Chrome executable not found. No changes made."
fi
