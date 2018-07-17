#lang racket/base

(require rackunit)
(require racket/trace)
(require simply-scheme)
(require "./stop-at-17.rkt")
(require "./twenty-one.rkt")
(require "./dealer-sensitive.rkt")
(require "./valentine.rkt")
(require "./majority.rkt")

(define (play-n strategy n)
  (if (= n 0)
    0
    (+ (twenty-one strategy) (play-n strategy (- n 1)))))

(play-n stop-at-17 50)
(play-n dealer-sensitive 50)
(play-n valentine 50)

(play-n (majority stop-at-17 dealer-sensitive valentine) 10)

;;; (define (loop f n)
;;;   (if (= n 0)
;;;       `()
;;;       (se (f) (loop f (- n 1)))))

;;; (loop (play-n dealer-sensitive 100) 100)