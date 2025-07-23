#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
    # macOS command
    fswatch -r --exclude _build . | while read; do 
        make html
    done
elif [[ "$(uname)" == "Linux" ]]; then
    # Linux command
    while inotifywait -r --exclude _build *; do 
        make html
    done
else
    # Other?
    echo "Sorry, unsure how to watch on this system..."
fi
