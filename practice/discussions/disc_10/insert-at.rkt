#lang racket

(require rackunit)

(define (swap n1 n2 vec)
  (let ([val1 (vector-ref vec n1)]
        [val2 (vector-ref vec n2)])
  (vector-set! vec n1 val2)
  (vector-set! vec n2 val1)))

(define (insert-at! vec i val)
  (define last (- (vector-length vec) 1))
  (define (loop n) 
    (if (equal? n i) 
        (vector-set! vec n val)
        (begin (swap n (- n 1) vec) 
               (loop (- n 1)))))
  (loop last))

(define a (vector "I" "am" "like" "you" #f #f))
(insert-at! a 2 "bohemian")
(check-equal? a (vector "I" "am" "bohemian" "like" "you" #f))