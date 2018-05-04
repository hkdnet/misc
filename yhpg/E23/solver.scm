(define (insns-length insns)
  (fold * 1 (map (lambda (insn) (if (equal? insn #\a) 4 5)) insns)))

(define (solve input)
  (let ((arr (string-split input ",")))
    (let ((idx (string->number (car arr))) (insns (string->list (cadr arr))))
      (if (< (insns-length insns) idx)
        "x" "nya"))))
