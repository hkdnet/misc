(define (insns-steps insns)
  (let loop ([ls '(1)] [rev-insns (reverse insns)])
    (if (null? rev-insns)
      ls
      (let ((m (if (equal? #\a (car rev-insns)) 4 5)))
        (loop (cons (* m (car ls)) ls) (cdr rev-insns))))))

(define (solve input)
  (let ((arr (string-split input ",")))
    (let ((idx (string->number (car arr))) (insns (string->list (cadr arr))))
      (let ((steps (insns-steps insns)))
        (if (< (car steps) idx)
          "x" (deg->str (solve-deg insns (- idx 1) 0 (cdr steps))))))))

(define (deg->str deg)
  (if (= deg 0) "0"
    (if (= deg 60) "+" "-")))

(define (normalize-deg deg)
  (modulo deg 180))

(define a-deg '(0 60 120 0))
(define b-deg '(0 60 0 120 0))

; returns (idx delta-deg)
(define (next-env insn idx step)
  (let ([q (quotient idx step)] [r (modulo idx step)])
    (if (equal? #\a insn)
      `(,r ,(list-ref a-deg q))
      `(,r ,(list-ref b-deg q)))))

(define (solve-deg insns idx deg steps)
  (if (null? (cdr insns))
    (if (equal? (car insns) #\a)
      (normalize-deg (+ deg (list-ref a-deg idx)))
      (normalize-deg (+ deg (list-ref b-deg idx))))
    (let ((n (next-env (car insns) idx (car steps))))
      (solve-deg (cdr insns) (car n) (normalize-deg (+ (cadr n) deg)) (cdr steps)))))
