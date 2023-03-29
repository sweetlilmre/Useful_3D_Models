#!/bin/bash
mkdir -p ./generated
for file in ./**/*.scad; do
    filePath="${file%.*}"
    inferredPath=$(echo "$filePath" | sed "s:.*/::")
    # For debugging
    # echo "$filePath -> $inferredPath"
    openscad "$filePath.scad" -o "./generated/$inferredPath.stl"
done

cp frame.html ./generated
cp index.html ./generated
cp -R stl_viewer/ generated/
