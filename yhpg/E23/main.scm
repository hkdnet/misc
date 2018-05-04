(load "../util/parser.scm")
(load "./solver.scm")

(let loop ([cases (file->testdata "test.txt")] [num 0])
  (if (not (null? cases))
    (let ((c (car cases)))
      (if (not (string=? (solve (car c)) (car (cdr c))))
        (display #"~num NG\n"))
      (loop (cdr cases) (+ num 1)))))



