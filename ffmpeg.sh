#!/bin/bash

# Batch FFmpeg script
# Converts all video files in the current directory to MP4 and compresses them.

# Set output directory
OUTPUT_DIR="./output"
mkdir -p "$OUTPUT_DIR"

# Loop through all video files in the directory
for file in *; do
  if [[ -f "$file" && "$file" != *.sh ]]; then
    # Get file name without extension
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    name="${filename%.*}"
    
    # Skip already processed MP4 files
    if [[ "$extension" == "mp4" ]]; then
      echo "Skipping $file (already MP4)"
      continue
    fi

    echo "Processing $file..."

    # Convert to MP4 with compression
    ffmpeg -i "$file" -vcodec libx264 -crf 23 "$OUTPUT_DIR/$name.mp4"

    echo "Finished processing $file. Output saved to $OUTPUT_DIR/$name.mp4"
  fi
done

echo "All files have been processed."
