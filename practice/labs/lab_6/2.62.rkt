#lang racket/base

(require rackunit)
(require racket/trace)

(define (union-set set1 set2)
  (cond [(null? set1) set2]
        [(null? set2) set1]
        [else (let ([x1 (car set1)]
                    [x2 (car set2)]) 
              (cond [(= x1 x2) 
                      (cons x1 (union-set (cdr set1) (cdr set2)))]
                    [(< x1 x2)
                      (cons x1 (union-set (cdr set1) set2))]
                    [else 
                      (cons x2 (union-set set1 (cdr set2)))]))]))

(check-equal? (union-set '() '(1 2 3)) '(1 2 3))
(check-equal? (union-set '(1 2 3) '()) '(1 2 3))
(check-equal? (union-set '(1 2 3 4 5 10 11 12 13) '(1 2 3 6 7 8 9)) '(1 2 3 4 5 6 7 8 9 10 11 12 13))