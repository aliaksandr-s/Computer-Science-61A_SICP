#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (interleave ls1 ls2)
  (cond [(null? ls1) ls2]
        [(null? ls2) ls1]
        [else (cons (car ls1) (cons (car ls2) (interleave (cdr ls1) (cdr ls2))))]))

(check-equal? (interleave '(a b c d) '(1 2 3 4 5 6 7)) '(a 1 b 2 c 3 d 4 5 6 7))
(check-equal? (interleave '(1 2 3 4 5 6 7) '(a b c d)) '(1 a 2 b 3 c 4 d 5 6 7))