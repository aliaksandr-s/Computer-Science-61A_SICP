#lang racket/base

(require rackunit)
(require simply-scheme)

(define (last-letter-e? wd)
  (equal? 
    (last wd)
    `e))

(define (ends-e seq) 
  (cond 
    [(empty? seq) 
      `()]
    [(last-letter-e? (first seq)) 
      (sentence 
        (first seq) 
        (ends-e (bf seq)))]
    [else 
      (ends-e (bf seq))]))


(check-equal? (ends-e `(please put the salami above the blue elephant)) `(please the above the blue))

(check-equal? (last-letter-e? `above) #t)
(check-equal? (last-letter-e? `log) #f)