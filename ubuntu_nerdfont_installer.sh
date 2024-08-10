#!/bin/bash
set -euo pipefail

fonts_dir="$HOME/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "$@"; do
    zip_file="$font.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$zip_file"
    echo "Downloading $download_url"
    wget -O "/tmp/$zip_file" "$download_url"
    unzip "/tmp/$zip_file" -d "/tmp/$font/"
    mv /tmp/$font/*.ttf "$fonts_dir"
    rm "/tmp/$zip_file"
    rm -rf "/tmp/$font/"
done

# Create cache directories if they do not exist
cache_dirs=(
    "$HOME/.cache/fontconfig"
    "$HOME/.fontconfig"
)

for dir in "${cache_dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
    fi
done

# Ensure the user has permissions to write to the cache directories
for dir in "${cache_dirs[@]}"; do
    if [[ -d "$dir" && ! -w "$dir" ]]; then
        echo "Warning: Directory $dir is not writable. Attempting to change permissions."
        chmod u+w "$dir"
    fi
done

# Update the font cache
fc-cache -fv

