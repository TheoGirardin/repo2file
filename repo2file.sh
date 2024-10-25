#!/bin/bash

# Output file
output_file="repofile.txt"

# Clear the output file if it already exists
> "$output_file"

# Write a classification description at the start of the file
echo "=== Project Structure and Code ===" >> "$output_file"
echo "This file contains the complete directory structure and code of each file," >> "$output_file"
echo "sorted alphabetically by directory." >> "$output_file"
echo "==========================================" >> "$output_file"
echo "" >> "$output_file"  # Add a blank line for better readability

# Define a blacklist array for files and folders to exclude
blacklist=(".env" ".git" ".gitignore" ".prettierrc" "docker-compose.yml" "next-env.d.ts" "next.config.js" "postcss.config.js" "tsconfig.tsbuildinfo" "types.d.ts" ".next" "package-lock.json" "node_modules" "dist" "build" "data" "public" "migrations")

# Function to check if an item is in the blacklist
is_blacklisted() {
    local item=$1
    for black in "${blacklist[@]}"; do
        if [[ "$item" == "$black" ]]; then
            return 0  # Item is blacklisted
        fi
    done
    return 1  # Item is not blacklisted
}

# Function to print file tree and content
print_tree_and_code() {
    local dir=$1

    # Get a list of files and directories, sorted alphabetically
    local items=($(ls -1 "$dir" | sort))

    # Print the directory structure
    echo "Directory: $dir" >> "$output_file"
    echo "---------------------------------" >> "$output_file"

    for item in "${items[@]}"; do
        local path="$dir/$item"

        # Skip blacklisted items
        if is_blacklisted "$item"; then
            continue
        fi

        if [[ -d "$path" ]]; then
            # If it's a directory, call the function recursively
            print_tree_and_code "$path"
        elif [[ -f "$path" ]]; then
            # If it's a file, print its path
            echo "File: $path" >> "$output_file"
            echo "---------------------------------" >> "$output_file"
            # Print the file content
            cat "$path" >> "$output_file"
            echo -e "\n" >> "$output_file"  # Add a newline after the content
        fi
    done
}

# Start from the current directory or provide a directory as an argument
start_dir=${1:-.}

# Call the function with the starting directory
print_tree_and_code "$start_dir"

echo "Tree structure and code have been printed to $output_file"

