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

(define (mul-stream s1 s2)
  (stream-map * s1 s2))

(define factorials (stream-cons 1 (mul-stream integers factorials)))

(define s1 (stream 1 2 3 4 5))
(define s2 (stream 1 2 3 4 5))


(check-equal? (stream->list (mul-stream s1 s2)) '(1 4 9 16 25))
(check-equal? (stream-take factorials 6) '(1 1 2 6 24 120))