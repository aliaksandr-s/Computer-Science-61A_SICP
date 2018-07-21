#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)


(define (count-change amount)
  (cc amount `(50 25 10 5 1)))

(define (cc amount kinds-of-coins)
  (cond 
    [(= amount 0) 1]
    [(or (< amount 0) (empty? kinds-of-coins)) 0]
    [else 
      (+ (cc amount (bf kinds-of-coins))
         (cc (- amount 
                (first kinds-of-coins))
             kinds-of-coins))]))

(define (first-denomination kinds-of-coins)
  (cond
    [(= kinds-of-coins 1) 1]
    [(= kinds-of-coins 2) 5]
    [(= kinds-of-coins 3) 10]
    [(= kinds-of-coins 4) 25]
    [(= kinds-of-coins 5) 50]))

(check-equal? (count-change 7) 2)
(check-equal? (count-change 100) 292)