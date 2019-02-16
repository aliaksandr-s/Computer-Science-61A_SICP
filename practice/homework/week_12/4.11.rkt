#lang racket

(require compatibility/mlist)
(require rackunit)

(define make-frame mlist)
(define (frame-variables frame)
  (mmap car frame))

(define (frame-values frame)
  (mmap cadr frame))

(define make-env mcons)
(define first-frame mcar)
(define enclosing-environment mcdr)
(define the-empty-environment '())

(define test-frame (make-frame '(x 1) '(y 2) '(z 3)))
(define test-env (make-env test-frame null))

(check-equal? (first-frame test-env) test-frame)
(check-equal? (frame-variables test-frame) (mlist 'x 'y 'z))
(check-equal? (frame-values test-frame) (mlist 1 2 3))
(check-equal? (enclosing-environment test-env) null)