#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (multiply sent) 
  (define (iter sent product)
    (if (empty? sent)
        product
        (iter (bf sent) (* product (first sent)))))
  (iter sent 1))

(check-equal? (multiply `(2 3 4 5)) 120)