#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (reverse l)
  (if (= (length l) 0) 
      l 
      (append (reverse (cdr l)) (list (car l)))))

(check-equal? (reverse (list 1 4 9 16 25)) '(25 16 9 4 1))