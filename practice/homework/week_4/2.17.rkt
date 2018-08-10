#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (last-pair ls)
  (if (null? (cdr ls)) 
      (list (car ls)) 
      (last-pair (cdr ls))))

(check-equal? (last-pair (list 23 72 149 34)) '(34))
