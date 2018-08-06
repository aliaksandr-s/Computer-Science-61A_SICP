#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (insert-after item mark ls)
  (define (iter item mark ls before)
    (if (= mark -1)
        (append before (list item) ls) 
        (iter item (- mark 1) (cdr ls) (append before (list (car ls))))))
  (iter item mark ls '()))

(check-equal? (insert-after 3 2 '(1 1 1 1)) '(1 1 1 3 1))