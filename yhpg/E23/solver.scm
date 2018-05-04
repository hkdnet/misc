(define (insns-length insns)
  (fold * 1 (map (lambda (insn) (if (equal? insn #\a) 4 5)) insns)))

(define (solve input)
  (let ((arr (string-split input ",")))
    (let ((idx (string->number (car arr))) (insns (string->list (cadr arr))))
      (if (< (insns-length insns) idx)
        "x" (deg->str (solve-deg insns idx 0))))))

(define (deg->str deg)
  (if (= deg 0) "0"
    (if (= deg 60) "+" "-")))

(define (normalize-deg deg)
  (modulo deg 180))

(define a-deg '(0 60 120 0))
(define b-deg '(0 60 0 120 0))

; reutnrs (idx delta-deg)
(define (next-env insn idx)
  (if (equal? #\a insn)
    (let ([q (quotient idx 4)] [r (modulo idx 4)])
      `(,q ,(list-ref a-deg r)))
    (let ((q (quotient idx 5)) [r (modulo idx 5)])
      `(,q ,(list-ref b-deg r)))))

(define (solve-deg insns idx deg)
  (if (null? (cdr insns))
    (if (equal? (car insns) #\a)
      (list-ref a-deg idx 0) ; TODO あとでとる
      (list-ref b-deg idx 0))
    (let ((n (next-env (car insns) idx)))
      (solve-deg (cdr insns) (car n) (normalize-deg (+ (cadr n) deg))))))
