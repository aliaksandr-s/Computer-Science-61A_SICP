#lang racket

(require rackunit)
(require racket/trace)

(define random-generator%
  (class object%
    (init-field range 
                [counter 0])
    (super-new)
    (define/public (number)
      (set! counter (+ 1 counter))
      (random range))
    (define/public (count)
      counter) ))

(define r10 (new random-generator% [range 10]))
(check-pred number? (send r10 number))
(check-pred number? (send r10 number))
(check-pred number? (send r10 number))
(check-equal? (send r10 count) 3)