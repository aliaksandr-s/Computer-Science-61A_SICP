#lang racket
(require rackunit)

(define (swap n1 n2 vec)
  (let ([val1 (vector-ref vec n1)]
        [val2 (vector-ref vec n2)])
  (vector-set! vec n1 val2)
  (vector-set! vec n2 val1)))

(define (buble-sort! vec)
  (define (loop len cur)
    (cond [(equal? len 1) 
            #f]
          [(equal? (- len 1) cur)
            (loop (- len 1) 0)]
          [(> (vector-ref vec cur) 
              (vector-ref vec (+ 1 cur)))
            (swap cur (+ 1 cur) vec)
            (loop len (+ 1 cur))]
          [else (loop len (+ 1 cur))]))
  (loop (vector-length vec) 0)
  vec)


(define v1 (vector 1 2 3))
(swap 0 1 v1)

(check-equal? v1 (vector 2 1 3))
(check-equal? (buble-sort! (vector 4 3 5 2 1)) (vector 1 2 3 4 5))
(define v2 (vector 5 2 3 1 4))
(buble-sort! v2)
(check-equal? v2 (vector 1 2 3 4 5))