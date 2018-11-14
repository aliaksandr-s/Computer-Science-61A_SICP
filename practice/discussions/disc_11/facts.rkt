#lang racket

(require rackunit)
(require racket/stream)
(require mischief/stream)

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply stream-map
              (cons proc (map stream-rest argstreams))))))

(define facts
  (stream-cons 1
               (stream-map * facts (stream-rest integers))))

(check-equal? (stream-take facts 4) '(1 2 6 24))