#lang racket/base

(require rackunit)
(require racket/trace)

(define (fib-a n)
  (if (or (= n 1) (= n 2))
    1
    (+ (fib-a (- n 2)) (fib-a (- n 1)))))

(check-equal? (fib-a 5) 5)
(check-equal? (fib-a 7) 13)

(define (fib-b n)
  (define (iter prev cur n)
    (cond [(= 1 n) prev] 
          [(= 2 n) cur]
          [else (iter cur (+ prev cur) (- n 1))]
      ))
  (iter 1 1 n))

(check-equal? (fib-b 5) 5)
(check-equal? (fib-b 7) 13)