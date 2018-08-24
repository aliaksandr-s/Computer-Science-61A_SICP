#lang racket/base

(require rackunit)
(require racket/trace)
(require simply-scheme)

(define (sum-1 sent) 
  (cond [(empty? sent) 0]
        [(number? sent) sent]
        [(and (= (count sent) 1) (word? sent)) 1]
        [else (+ (sum-1 (first sent)) (sum-1 (bf sent)))]))

(check-equal? (sum-1 '(i can do it 9 times)) 22)
(check-equal? (sum-1 '(20 percent cooler)) 33)

(define (sum-2 sent)
  (accumulate + (every (lambda (x) (if (number? x) x (count x))) sent)))

(check-equal? (sum-2 '(i can do it 9 times)) 22)
(check-equal? (sum-2 '(20 percent cooler)) 33)