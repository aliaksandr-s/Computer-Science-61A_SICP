#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (sum-of-sents sent-1 sent-2)
  (cond [(< (count sent-1) (count sent-2)) (sum-of-sents sent-2 sent-1)]
        [(empty? sent-2) sent-1]
        [else (se (+ (first sent-1) (first sent-2)) 
                  (sum-of-sents (bf sent-1) (bf sent-2)))]))

(check-equal? (sum-of-sents `(1 2 3) `(6 3 9)) `(7 5 12))
(check-equal? (sum-of-sents `(1 2) `(1 2 3 4 5)) `(2 4 3 4 5))
(check-equal? (sum-of-sents `(1 2 3 4 5) `(1 2)) `(2 4 3 4 5))