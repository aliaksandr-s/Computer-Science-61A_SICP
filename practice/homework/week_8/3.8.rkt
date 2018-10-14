#lang racket

(require rackunit)

(define f
  (let ([called? #f]) 
  (lambda (arg) 
    (if (not called?) 
        (begin (set! called? #t) arg)
        0))))


;;; (check-equal? (+ (f 0) (f 1)) 0)
(check-equal? (+ (f 1) (f 0)) 1)