(load "../util/parser.scm")
(load "./solver.scm")

(let loop ([cases (file->testdata "test.txt")])
  (if (not (null? cases))
    (let ((c (car cases)))
      (if (string=? (solve (car c)) (car (cdr c)))
        (display "ok\n")
        (display "NG\n"))
      (loop (cdr cases)))))



