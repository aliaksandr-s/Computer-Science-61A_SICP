#lang racket

(require rackunit)

(define (vector-append v1 v2)
  (define len (+ (vector-length v1) 
                 (vector-length v2)))
  (define vec (make-vector len))

  (define (loop v n l p)
    (cond [(eq? n l) #f]  
          [else (vector-set! vec p (vector-ref v n))
                (loop v (+ n 1) l (+ p 1))]))

  (loop v1 0 (vector-length v1) 0)
  (loop v2 0 (vector-length v2) (vector-length v1))
  
  vec)


(define v1 (vector 1 2 3))
(define v2 (vector 4 5 6))

(check-equal? (vector-append v1 v2) (vector 1 2 3 4 5 6))