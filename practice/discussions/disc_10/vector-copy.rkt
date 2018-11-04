#lang racket

(require rackunit)

(define (vector-copy! src src-start dst dst-start length)
  (if (equal? length 0) 
      'done
      (begin (vector-set! dst dst-start (vector-ref src src-start)) 
             (vector-copy! src (+ 1 src-start) dst (+ 1 dst-start) (- length 1)))))

(define a (vector 1 2 3 4 5 6 7 8 9 10))
(define b (vector 'a 'b 'c 'd 'e 'f 'g 'h 'i 'j 'k))
(vector-copy! a 5 b 2 3)
(check-equal? a (vector 1 2 3 4 5 6 7 8 9 10))
(check-equal? b (vector 'a 'b 6 7 8 'f 'g 'h 'i 'j 'k))