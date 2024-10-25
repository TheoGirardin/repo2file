# repo2file

`repo2file` is a simple yet powerful bash script designed to generate a complete, text-based file containing the entire folder structure and file contents of a project. It’s particularly useful for developers who want to share or document their project structure without manually copying and pasting each file.

## Features

-   **Recursive Project Export**: Traverses your project directory recursively to capture all files and folders.
-   **Configurable Exclusions**: Add files or directories to a blacklist to exclude them from the final output.
-   **Alphabetical Organization**: Ensures files and folders are sorted alphabetically in the output for easy navigation.
-   **Single Output File**: Combines all folder structure and file contents into one file for straightforward sharing and documentation.

## Example Use Case

Use `repo2file` to create a snapshot of your project, omitting unnecessary files (e.g., `node_modules`, `.git`, build artifacts) and focusing on the main source code.

## Getting Started

### Prerequisites

-   **Bash**: This script requires a bash-compatible environment.
-   **Permissions**: Ensure you have read access to all files and folders in the project directory.

### Installation

Clone this repository or download the script directly:

```bash
git clone https://github.com/yourusername/repo2file.git
cd repo2file
```

### Make the script executable:

```bash
chmod +x repo2file.sh
```

### Usage

Run repo2file from the root directory of your project. By default, it will output a file named repofile.txt with all the directory structure and file content included, minus the blacklisted files and folders.

```bash
./repo2file.sh
```

Optional: Specify a Starting Directory
You can specify the directory from which to start:

```bash
./repo2file.sh /path/to/project
```

### Blacklist Configuration

The script includes a customizable blacklist to exclude specific files or folders. By default, repo2file excludes folders like .next, node_modules, .git, and others. You can add or modify these exclusions by editing the blacklist array in the script:

```bash
# Default Blacklist
blacklist=("node_modules" ".next" "dist" "build" ".git" "README.md" "migrations")
```

To exclude specific directories or files, add them to this array.

### Output

The generated repofile.txt file includes:

A complete directory structure, sorted alphabetically
Code from every file not excluded in the blacklist
A header with a brief description of the project’s structure
Example Output

```markdown
=== Project Structure and Code ===
This file contains the complete directory structure and code of each file,
sorted alphabetically by directory.
==========================================

## Directory: src

## File: src/index.js

<file contents here>

## Directory: src/components

## File: src/components/Header.js

<file contents here>
```

...

### Contributing

Feel free to submit issues or pull requests to improve repo2file. Contributions are always welcome!

### License

This project is licensed under the MIT License.
