#lang racket

(require rackunit)
(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
(require racket/trace)

(define (count-pairs x)
  (let ([counted (mlist #f)])
    (define (count x)
      (if (or (not (mpair? x)) (mmemq x counted))
          0
          (begin (set! counted (mcons x counted))
                 (+ (count (mcar x))
                    (count (mcdr x)) 1)
              )))
    (count x)))


(define l3 (mlist 1 2 3))
(check-equal? (count-pairs l3) 3)

(define l41 (mlist 1))
(define l4 (mlist l41 l41))
(check-equal? (count-pairs l4) 3)

(define l71 (mlist 1))
(define l72 (mcons l71 l71))
(define l7 (mcons l72 l72))
(check-equal? (count-pairs l7) 3)