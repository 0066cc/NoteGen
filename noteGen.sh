#!/bin/bash
metaFile="metaData.md"
# Temporary Files
tmp=".${1}.tmp"
tmpFormat=".${1}.tmp2"
tmpOut=".${1}.tmpOut"
tmpFinalFormat=".${1}.tmp3"
date=$(date +"%Y-%m-%d")
# This is NULL if not specified in which case the outputted file be created wherever the script was ran from
pathOut=${2}
# General formatting
# Get the title for the document by pulling from the first header tag, trim any unneccesary formatting
docTitle=$(grep -o -a -m 1 -h -w -ri "#.*" "$1" | head -1 | cut -c 3-)
# File name uses first title but swap spaces for underscores
fileTitle=$(echo "$docTitle" |  tr -s ' ' '_')
# Handle directory processing and creation
if [ -z "$pathOut" ]
then
    echo "* No output path has been specified, generating file in home directory."
    pathOut="$HOME"
else
    echo "* An output path has been specified, generating file in ${pathOut} directory."
    if [ ! -d "$pathOut" ]; then
        if mkdir -p "$pathOut"; then
            echo "* ${pathOut} didn't seem to exist, creating that directory now."
        else
            echo "* Couldn't create that directory. Exit status: $?"
            echo "* Falling back to home directory output."
            pathOut="$HOME"
        fi
    fi
fi
outFile="${pathOut}/${fileTitle}.pdf"

# Start conversion
echo "! Generating notes for: $1"
# Echoing nothing is used as 'touch' caused errors
echo -n "" > $tmpOut
echo -n "" > $tmpFinalFormat
# Delete the first heading line so there's no repeated header in the document
sed '1d' $1 > $tmpOut
# Append newline to headings
sed -e  's/#.*/\n & \n/' $tmpOut > $tmpFinalFormat
# Remove leading whitespace
sed -e 's/^[ \t]*//' $tmpFinalFormat > $tmpOut
# Fix list start colon
sed -e  's/:/:\n/' $tmpOut > $tmpFinalFormat
echo -n "" > $tmp
echo -n "" > $tmpFormat
# Insert metadata
printf "0r $metaFile\nwq\n" | ed -s $tmp
# Insert title
sed "2s/$/ '$docTitle'/" $tmp > $tmpFormat
# Insert date
sed "3s/$/ $date/" $tmpFormat > $tmp
cat $tmpFinalFormat >> $tmp

# The actual conversion:
# -t latex = convert into LaTeX
# -o = output file and filetype
# --highlight-style = Apply syntax highlighting to code-blocks (Not supported everywhere)
# -V colorlinks -V urlcolor=NavyBlue -V toccolor=Black = Apply colouring to TOC and URLs
# -N = Generate TOC
# --variable=fontfamily:helvet = Use Helvetica
# --variable=fontfamily:helvet = Allow LaTeX macros in Markdown
pandoc $tmp -t latex -o ${outFile} --highlight-style zenburn -V colorlinks -V urlcolor=NavyBlue -V toccolor=Black -N -f markdown-latex_macros --variable=fontfamily:helvet

# Clean up
rm $tmp
rm $tmpOut
rm $tmpFormat
rm $tmpFinalFormat
# Done!
echo "! PDF ready for: $1"
exit
