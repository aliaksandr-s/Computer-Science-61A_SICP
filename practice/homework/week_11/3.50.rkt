#lang racket

(require rackunit)
(require racket/stream)

(define (stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply stream-map
              (cons proc (map stream-rest argstreams))))))

(define s1 (stream 1 2 3 4 5))
(define s2 (stream 1 2 3 4 5))
(define s3 (stream 1 2 3 4 5))

(define ss (stream-map + s1 s2 s3))
(check-equal? (stream->list ss) '(3 6 9 12 15))