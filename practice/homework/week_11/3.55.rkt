#lang racket

(require rackunit)
(require racket/stream)
(require mischief/stream)

(define (stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply stream-map
              (cons proc (map stream-rest argstreams))))))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (add-stream s1 s2)
  (stream-map + s1 s2))

(define (partial-sums s)
  (stream-cons (stream-first s) 
               (add-stream (partial-sums s) 
                           (stream-rest s))))

(check-equal? (stream-take (partial-sums integers) 6) '(1 3 6 10 15 21))