#lang racket

(require rackunit)
(require racket/stream)
(require mischief/stream)

(define (num-seq n)
  (cond [(< n 1) empty-stream] 
         [(odd? n) (stream-cons n (num-seq (+ (* 3 n) 1)))] 
         [else (stream-cons n (num-seq (/ n 2)))]))

(check-equal? (stream-take (num-seq 7) 7) '(7 22 11 34 17 52 26))