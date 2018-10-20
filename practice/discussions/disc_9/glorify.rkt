#lang sicp

(define ls '(1 2 (3 (4) 5)))

(define (glorify! L)
  (cond ((null? L) 'done)
        ((number? (car L))
          (set-car! L 'colleen)
          (glorify! (cdr L)))
        (else (glorify! (car L))
              (glorify! (cdr L)))))

(glorify! ls)
ls