# Recursive
Recursive is a static site generator written in Common Lisp.
## Usage
Recursive turns Common Lisp files into static html, enabling you to write full websites in Common Lisp. Running `ssg.lisp` in a directory that contains a directory `src` will convert all lisp files in `src` into html files in directory `dist`.
Recursive makes use of the function `tag` to write html tags. Check out `example-src` for what this looks like.
