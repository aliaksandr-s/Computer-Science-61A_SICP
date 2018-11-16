#lang racket

(require rackunit)
(require racket/stream)
(require mischief/stream)

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))
(define ones (stream-cons 1 ones))

(define (make-altering s)
  (let ([altered #f])
       (define (helper str) 
         (if altered 
             (begin (set! altered #f) 
                    (stream-cons (- (stream-first str))
                                 (helper (stream-rest str)))) 
             (begin (set! altered #t) 
                    (stream-cons (stream-first str)
                                 (helper (stream-rest str)))) )) 
       (helper s) ))

(define (make-alternating s)
  (stream-cons (stream-first s)
               (stream-cons (* -1 (stream-first (stream-rest s)))
                            (make-alternating (stream-rest (stream-rest s))))))

(check-equal? (stream-take (make-altering ones) 5) '(1 -1 1 -1 1))
(check-equal? (stream-take (make-altering integers) 5) '(1 -2 3 -4 5))