#lang racket/base

(require rackunit)
(require racket/trace)
(require "./11.rkt")

(provide unique-elements)

(define (unique-elements ls)
  (if (null? ls) 
      '() 
      (cons (car ls) (unique-elements (remove (car ls) (cdr ls))))))

(check-equal? (unique-elements '(3 5 6 3 3 5 9 8)) '(3 5 6 9 8))