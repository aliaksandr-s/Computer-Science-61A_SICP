#lang racket/base

(require rackunit)
(require racket/trace)

(define (square n) (* n n))

(define (square-deep-1 ls)
  (if (list? ls) 
      (map (lambda (el) (square-deep-1 el)) ls)
      (square ls)))

(define (square-deep-2 ls)
  (cond [(null? ls) '()]
        [(not (list? ls)) (square ls)]
        [else (cons (square-deep-2 (car ls)) 
                    (square-deep-2 (cdr ls)))]))

(define t1 '(1 (2 (3 4) 5) (6 7)))

(check-equal? (square-deep-1 t1) '(1 (4 (9 16) 25) (36 49)))
(check-equal? (square-deep-2 t1) '(1 (4 (9 16) 25) (36 49)))