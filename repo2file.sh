#!/bin/bash

# Output file
output_file="repofile.txt"
temp_file=$(mktemp)  # Temporary file to avoid conflict

# Clear the output file if it already exists
> "$output_file"

# Write a classification description at the start of the file
echo "=== Project Structure and Code ===" >> "$temp_file"
echo "This file contains the complete directory structure and code of each file," >> "$temp_file"
echo "sorted alphabetically by directory." >> "$temp_file"
echo "=== Project Explanation ===" >> "$temp_file"
echo "This project is a NextJS website, using tailwind for CSS, Vercel to be deployed, prisma as his ORM and auth.js for authentication," >> "$temp_file"
echo "==========================================" >> "$temp_file"
echo "" >> "$temp_file"  # Add a blank line for better readability

# Add the directory structure in tree format to the output
echo "=== Project Directory Tree ===" >> "$temp_file"
echo "---------------------------------" >> "$temp_file"
tree -a -I 'node_modules|.git|dist|build|public|migrations|data|.next' >> "$temp_file"
echo "" >> "$temp_file"  # Add a blank line after the tree

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

# Function to clean up file content
clean_file_content() {
    local input_file=$1
    local temp_cleaned=$(mktemp)
    
    # Remove multi-line comments
    sed -e 's/{\/\*.*\*\/}//g' -e 's/{\/\*.*//g' -e 's/.*\*\/}//g' "$input_file" |
    # Remove lines starting with //
    grep -v '^\s*\/\/' > "$temp_cleaned"
    
    cat "$temp_cleaned"
    rm "$temp_cleaned"
}

# Function to print file tree and content
print_tree_and_code() {
    local dir=$1

    # Get a list of files and directories, sorted alphabetically
    local items=($(ls -1 "$dir" | sort))

    # Print the directory structure
    echo "Directory: $dir" >> "$temp_file"
    echo "---------------------------------" >> "$temp_file"

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
            echo "File: $path" >> "$temp_file"
            echo "---------------------------------" >> "$temp_file"
            
            # Clean and print file content
            clean_file_content "$path" >> "$temp_file"
            
            echo -e "\n" >> "$temp_file"  # Add a newline after
        fi
    done
}

# Start from the current directory or provide a directory as an argument
start_dir=${1:-.}

# Call the function with the starting directory
print_tree_and_code "$start_dir"

# Move the temp file contents to the output file after completion
mv "$temp_file" "$output_file"

echo "Tree structure and code have been printed to $output_file"