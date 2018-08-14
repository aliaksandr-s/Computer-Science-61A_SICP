#lang racket/base

(require rackunit)
(require "./2.46.rkt")

(provide (all-defined-out))

(define (make-segment start-segment end-segment) 
  (cons start-segment end-segment))
(define (start-segment segment) 
  (car segment))
(define (end-segment segment) 
  (cdr segment))

(check-equal? (start-segment 
                (make-segment (make-vect 1 2) (make-vect 3 4))) 
              (make-vect 1 2))
(check-equal? (end-segment 
                (make-segment (make-vect 1 2) (make-vect 3 4))) 
              (make-vect 3 4))