#lang racket

(require rackunit)
(require racket/stream)
(require mischief/stream)

(define (list->stream ls)
  (if (null? ls)
      empty-stream
      (stream-cons (car ls)
               (list->stream (cdr ls))) ))

(check-equal? (stream-take (list->stream '(1 2 3 4 5)) 5) '(1 2 3 4 5))