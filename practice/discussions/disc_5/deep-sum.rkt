#lang racket/base

(require rackunit)
(require racket/trace)

(define (deep-sum lst)
  (cond [(null? lst) 0]
        [(not (list? lst)) lst]
        [else (+ (deep-sum (car lst)) (deep-sum (cdr lst)))]))

(check-equal? (deep-sum '(1 (2 3) (4 (5) 6) (7 (8 9) ))) 45)