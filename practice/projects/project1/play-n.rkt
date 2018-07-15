#lang racket/base

(require rackunit)
(require simply-scheme)
(require "./stop-at-17.rkt")
(require "./twenty-one.rkt")

(define (play-n strategy n)
  (if (= n 0)
    0
    (+ (twenty-one strategy) (play-n strategy (- n 1)))))

;;; (play-n stop-at-17 5)