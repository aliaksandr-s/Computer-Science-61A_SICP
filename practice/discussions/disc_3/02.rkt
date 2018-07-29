#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (ab+c a b c)
  (if (= b 0)
	    c
      (ab+c a (- b 1) (+ c a))))

(check-equal? (ab+c 1 2 3) 5)
(check-equal? (ab+c 4 3 7) 19)
(check-equal? (ab+c 0 9 5) 5)
(check-equal? (ab+c 5 0 5) 5)
