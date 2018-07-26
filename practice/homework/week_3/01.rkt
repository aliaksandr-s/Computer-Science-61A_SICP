#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (square x) (* x x))

(define (squares sent)
  (define (iter old-sent new-sent)
    (if (empty? old-sent)
        new-sent
        (iter (bf old-sent) (se new-sent (square (first old-sent))))))
  (iter sent `()))

(check-equal? (squares `(2 3 4 5)) `(4 9 16 25))
