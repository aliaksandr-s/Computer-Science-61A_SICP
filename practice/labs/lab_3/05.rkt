#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (count-change amount)
  (cc amount 1))

(define (cc amount kinds-of-coins)
  (cond 
    [(= amount 0) 1]
    [(or (< amount 0) (> kinds-of-coins 5)) 0]
    [else 
      (+ (cc amount (+ kinds-of-coins 1))
         (cc (- amount 
                (first-denomination kinds-of-coins))
             kinds-of-coins))]))

(define (first-denomination kinds-of-coins)
  (cond
    [(= kinds-of-coins 1) 1]
    [(= kinds-of-coins 2) 5]
    [(= kinds-of-coins 3) 10]
    [(= kinds-of-coins 4) 25]
    [(= kinds-of-coins 5) 50]))

; (trace cc)

(check-equal? (count-change 7) 2) ; 87 - cc calls
(check-equal? (count-change 100) 292)