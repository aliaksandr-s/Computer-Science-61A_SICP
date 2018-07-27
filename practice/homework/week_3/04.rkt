#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (square x) (* x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (cond [(= n 0) 1]
        [(even? n) (square (fast-expt b (/ n 2)))]
        [else (* b (fast-expt b (- n 1)))]))

(check-equal? (fast-expt 3 2) 9)
(check-equal? (fast-expt 1 3) 1)
(check-equal? (fast-expt 2 10) 1024)

 (define (fast-expt-iter b n) 
   (define (iter a b n) 
     (cond ((= n 0) a) 
           ((even? n) (iter a (square b) (/ n 2))) 
           (else (iter (* a b) b (- n 1))))) 
   (iter 1 b n)) 

(check-equal? (fast-expt-iter 3 2) 9)
(check-equal? (fast-expt-iter 1 3) 1)
(check-equal? (fast-expt-iter 2 10) 1024)

