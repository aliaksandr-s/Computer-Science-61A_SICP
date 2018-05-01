#lang racket/base

(require rackunit)
(require simply-scheme)

(define (substitute sent old-word new-word) 
  (cond
    [(empty? sent) 
      `()]
    [(equal? (first sent) old-word) 
      (sentence 
        new-word 
        (substitute (bf sent) old-word new-word)
      )]
    [else 
      (sentence 
        (first sent)
        (substitute (bf sent) old-word new-word))]
  ))


(check-equal? 
  (substitute `(she loves you yeah yeah yeah) `yeah `maybe)
  `(she loves you maybe maybe maybe))
