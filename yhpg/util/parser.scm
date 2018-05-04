(use srfi.13)
(use file.util)
(use gauche.generator)

(define (file->testdata filename)
  (let ((lines (filter (lambda (s) (not (string-null? s))) (string-split (file->string filename) "\n"))))
    (map (lambda (line)
      (let ((m (rxmatch #/"(?<input>.*)", "(?<expected>.*)"/ line)))
        `(,(m 1) ,(m 2)))) lines)))
