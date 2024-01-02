#!/bin/zsh

# Set the source and destination directories
source_dir="obsidian local folder"
dest_dir="clound mounted folder"
log_file="obsidian-sync.log"

# Help function to display help banner
show_help() {
  echo "Obsidian free sync is a free script that syncs"
  echo "Usage: $0 [--log | -l logfile] | [--help|-h]"
  echo "--log, -l    Enable logging to the specified logfile"
  echo "--help, -h   Show help banner"
}

# Check for command-line arguments
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  show_help
  exit 0
elif [ "$1" = "--log" ] || [ "$1" = "-l" ]; then
  if [ -n "$2" ]; then
    log_file="$2"
    echo "Logging enabled to $log_file"
  else
    echo "Please provide a filename for the log using --log|-l option."
    show_help
    exit 1
  fi
fi

# Function to log messages to the specified log file
log_message() {
  if [ -n "$log_file" ]; then
    echo "$(date '+%d-%m-%Y %H:%M:%S') : $1" >> "$log_file"
  fi
}

# Function to update the last successful copy date to the log file
log_last_successful_copy() {
  if [ -n "$log_file" ]; then
    echo "Last successful copy date: $(date '+%d-%m-%Y %H:%M:%S')" > "$log_file"
  fi
}

# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
  echo "Source directory '$source_dir' does not exist."
  exit 1
fi

# Get the list of files in the source directory
files=$(find "$source_dir" -type f)

# Loop through each file in the source directory
for file in $files; do
  # Get the file name and size
  filename=$(basename "$file")
  file_size=$(stat -f%b "$file")

  # Check if the file exists in the destination directory
  dest_file="$dest_dir/$filename"
  if [ ! -f "$dest_file" ]; then
    # File does not exist in the destination directory, copy it
    echo "Copying $file to $dest_file..."
    cp "$file" "$dest_file"
    log_message "Copied $file to $dest_file"
  else
    # File exists in the destination directory, check if it has been modified
    last_file_size=$(stat -f%b "$dest_file")
    if [ $file_size -ne $last_file_size ]; then
      # File has been modified, copy it
      echo "File $file has been modified. Copying to $dest_file..."
      cp "$file" "$dest_file"
      log_message "File $file has been modified. Copied to $dest_file"
    else
      log_message "File $file already exists and is up to date"
    fi
  fi
done

log_last_successful_copy
