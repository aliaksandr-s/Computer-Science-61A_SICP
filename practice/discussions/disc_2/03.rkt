#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (subsent sent i)
  (if (= i 0)
      sent
      (subsent (bf sent) (- i 1))))

(check-equal? (subsent `(6 4 2 7 5 8) 3) `(7 5 8))
(check-equal? (subsent `(6 4) 0) `(6 4))