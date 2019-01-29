#lang racket

(require rackunit)

(provide (all-defined-out))

(define make-frame cons)
(define frame-variables car)
(define frame-values cdr)

(define make-env cons)
(define first-frame car)
(define enclosing-environment cdr)

(define test-frame (make-frame '(x y) '(1 2)))
(define test-env (make-env test-frame null))

(check-equal? (first-frame test-env) test-frame)
(check-equal? (frame-variables test-frame) '(x y))
(check-equal? (frame-values test-frame) '(1 2))
(check-equal? (enclosing-environment test-env) null)