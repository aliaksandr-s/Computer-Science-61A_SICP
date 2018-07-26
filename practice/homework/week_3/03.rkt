#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (sum-of-factors n)
  (define (iter cur-n orig-n sum)
    (cond [(= cur-n 0) 
              sum]
          [(= (remainder orig-n cur-n) 0) 
              (iter (- cur-n 1) orig-n (+ sum cur-n))]
          [else 
              (iter (- cur-n 1) orig-n sum)]))
  (iter (- n 1) n 0))

(check-equal? (sum-of-factors 6) 6)
(check-equal? (sum-of-factors 5) 1)
(check-equal? (sum-of-factors 28) 28)

(define (next-perf n)
  (if (= (sum-of-factors n) n)
      n
      (next-perf (+ n 1))))

(check-equal? (next-perf 2) 6)
(check-equal? (next-perf 10) 28)