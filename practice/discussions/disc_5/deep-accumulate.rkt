#lang racket/base

(require rackunit)
(require racket/trace)

(define (deep-accumulate proc init lst)
  (cond [(null? lst) init]
        [(not (list? lst)) lst]
        [else (proc (deep-accumulate proc init (car lst)) 
                    (deep-accumulate proc init (cdr lst)))]))

(check-equal? (deep-accumulate * 1 '(1 2 (3 4) (5 (6) (7 8)))) 40320)

