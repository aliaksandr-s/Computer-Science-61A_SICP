#lang racket

(require rackunit)

(define fib
  (let ([cur 1] 
        [next 2]) 
    (lambda ()
      (let ([res cur]) 
        (set! cur next)
        (set! next (+ res next))
        res))))

(check-equal? (fib) 1)
(check-equal? (fib) 2)
(check-equal? (fib) 3)
(check-equal? (fib) 5)
(check-equal? (fib) 8)