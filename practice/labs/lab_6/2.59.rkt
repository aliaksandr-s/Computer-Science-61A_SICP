#lang racket/base

(require rackunit)
(require racket/trace)

(define (element-of-set? x set)
  (cond [(null? set) #f]
        [(equal? x (car set)) #t]
        [else (element-of-set? x (cdr set))]))

(define (union-set set1 set2)
  (cond [(null? set1) set2]
        [(null? set2) (union-set set2 set1)]
        [(element-of-set? (car set1) set2)
          (union-set (cdr set1) set2)]
        [else (append (list (car set1)) 
                    (union-set (cdr set1) set2))]))

(check-equal? (element-of-set? 3 '(1 2 3)) #t)
(check-equal? (element-of-set? 5 '(1 2 3)) #f)
(check-equal? (union-set '() '(1 2 3)) '(1 2 3))
(check-equal? (union-set '(1 2 3) '()) '(1 2 3))
(check-equal? (union-set '(5 4 1 3 2) '(1 7 6 9 8 3 2)) '(5 4 1 7 6 9 8 3 2))