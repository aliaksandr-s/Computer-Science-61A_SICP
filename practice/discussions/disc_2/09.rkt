#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (keep pred? sent)
  (cond ((empty? sent) 
          `())
        ((pred? (first sent))
          (sentence (first sent) (keep pred? (bf sent))))
        (else 
          (keep pred? (bf sent)))))

(define (< x)
  (lambda (y) (> x y)))

(check-equal? (keep (< 6) `(4 5 6 7 8)) `(4 5))