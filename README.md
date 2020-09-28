# NoteGen
A small script for generator LaTeX PDFs from Markdown using Pandoc metadata.

The script automatically fixes formatting errors that may produce incorrect documents by restructuring header spacing, removing repeated header text, trimming leading white-space removal, among other features resulting in consistently high-quality output. All without editing the original file.

Due to some commands not supporting rewriting in-place, temporary files are used to accomodate for this. These files are automatically deleted upon script completion.
