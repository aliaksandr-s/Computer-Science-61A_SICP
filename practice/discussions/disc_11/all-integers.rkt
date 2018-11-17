#lang racket

(require rackunit)
(require racket/stream)
(require mischief/stream)

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))
(define negatives (stream-map (lambda (el) (* -1 el)) integers))
(define all-integers (stream-cons 0 (stream-interleave integers negatives)))

(check-equal? (stream-take all-integers 9) '(0 1 -1 2 -2 3 -3 4 -4))