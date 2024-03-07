#!/bin/bash

# Splash screen
echo "*********************************************************************"
echo "        IcnsGen - Utility to create .icns for Application Bundles     "
echo "         Copyright (c) 2024 RoyalGraphX - BSD 3-Clause License "
echo "                        Bash Version 1.0.0           "
echo "*********************************************************************"
echo

# Input image selection
echo "Available PNG images in the current directory:"
select img_file in *.png; do
    if [[ -n $img_file ]]; then
        input_img=$(pwd)/"$img_file"
        # Extract the filename without extension
        filename="${img_file%.*}"
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# Output directory setup
output_dir="./$filename"
if [[ -d $output_dir.iconset ]]; then
    count=1
    while [[ -d "${output_dir}_${count}.iconset" ]]; do
        ((count++))
    done
    output_dir="${output_dir}_${count}.iconset"
else
    output_dir="${output_dir}.iconset"
fi
mkdir -p "$output_dir"

# Generating icons
for size in 16 32 64 128 256 512; do
    half=$((size / 2))
    convert "$input_img" -resize "${size}x${size}" "$output_dir/icon_${size}x${size}.png"
    convert "$input_img" -resize "${size}x${size}" "$output_dir/icon_${half}x${half}@2x.png"
done

echo "Icons generated successfully in $output_dir"

# Creating icns file
echo "Generating final .icns file"
iconutil -c icns "$output_dir"
