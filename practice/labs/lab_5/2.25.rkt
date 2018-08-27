#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (selector-1 ls) (car (cdaddr ls)))
(check-equal? (selector-1 (list 1 3 (list 5 7) 9)) 7)

(define selector-2 caar)
(check-equal? (selector-2 '((7))) 7)

(define (selector-3 ls) (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr ls)))))))))))))
(check-equal? (selector-3 '(1 (2 (3 (4 (5 (6 7))))))) 7)