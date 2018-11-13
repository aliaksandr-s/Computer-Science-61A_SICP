#lang racket

(require rackunit)
(require racket/stream)
(require mischief/stream)

(require "./num-seq.rkt")

(define (seq-length seq)
  (if (equal? (stream-first seq) 1) 
      1
      (+ 1 (seq-length (stream-rest seq)))))

(check-equal? (seq-length (num-seq 7)) 17)