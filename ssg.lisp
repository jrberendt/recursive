(defvar current-html "")

(defun concat-str-list (lst sep)
  (if
   (atom lst)
   lst
   (reduce
    (lambda (a b)
      (concatenate 'string a sep b))
    (cdr lst)
    :initial-value (car lst))))

(defun split-str-list (string delimiterp)
  (loop :for beg = (position-if-not delimiterp string)
    :then (position-if-not delimiterp string :start (1+ end))
    :for end = (and beg (position-if delimiterp string :start beg))
    :when beg :collect (subseq string beg end)
    :while end))

(defun delimiterp (c) (char= c #\Space))

(defun tag (type &rest body)
  (setq current-html (concatenate 'string "<" type ">" (concat-str-list body "") "</" (first (split-str-list type #'delimiterp)) ">"))
  current-html
  )

(mapcar (lambda (path)
	  (load path)
	  (let ((built-path (concat-str-list (append '("dist") (rest (rest (append (pathname-directory (enough-namestring path)) (list (concatenate 'string (pathname-name path) ".html")))))) "/")))
	    (ensure-directories-exist built-path)
	    (with-open-file (str built-path
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)
	     (format str current-html))
	    ))
	(directory "./src/**/*.lisp"))
