#lang racket

(require rackunit)

(provide (all-defined-out))

(define make-frame mcons)
(define frame-variables mcar)
(define frame-values mcdr)

(define make-env mcons)
(define first-frame mcar)
(define enclosing-environment mcdr)
(define the-empty-environment '())

(define test-frame (make-frame '(x y) '(1 2)))
(define test-env (make-env test-frame null))

(check-equal? (first-frame test-env) test-frame)
(check-equal? (frame-variables test-frame) '(x y))
(check-equal? (frame-values test-frame) '(1 2))
(check-equal? (enclosing-environment test-env) null)