(load "../util/parser.scm")
(load "./solver.scm")

(let loop ([cases (file->testdata "test.txt")] [num 0])
  (if (not (null? cases))
    (let ((c (car cases)))
      (let ([actual (solve (car c))] [expected (cadr c)])
        (if (not (equal? actual expected))
          (display #"~num NG actual: ~actual expected: ~expected\n")))
      (loop (cdr cases) (+ num 1)))))