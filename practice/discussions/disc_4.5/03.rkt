#lang racket/base

(require rackunit)
(require racket/trace)

(define (merge ls1 ls2)
  (cond [(null? ls1) ls2]
        [(null? ls2) ls1]
        [(= (car ls1) (car ls2)) (merge ls1 (cdr ls2))]
        [(< (car ls1) (car ls2)) 
              (cons (car ls1) (merge (cdr ls1) ls2))]
        [else (cons (car ls2) (merge ls1 (cdr ls2)))]))

(check-equal? (merge (list 1 2 3 4) (list 5 6 7 8)) (list 1 2 3 4 5 6 7 8))
(check-equal? (merge (list 1 3 4 6) (list 3 5 7 8)) (list 1 3 4 5 6 7 8))

(define (sublist ls start end)
  (define (iter ls new-ls start end cur)
    (cond [(= start end cur) new-ls]
          [(< cur start) (iter (cdr ls) new-ls start end (+ cur 1))]
          [else (iter (cdr ls) (append new-ls (list (car ls))) (+ start 1) end (+ cur 1))]))
  (iter ls '() start end 0))

(check-equal? (sublist (list 2 3 4 5) 1 3) (list 3 4))
(check-equal? (sublist (list 1 2 3 4 5) 0 3) (list 1 2 3))
(check-equal? (sublist (list 1 2 3 4 5) 3 5) (list 4 5))

(define (mergesort ls)
  (if (or (null? ls) (= (length ls) 1)) 
    ls
    (let ([middle (round (/ (length ls) 2))])
      (merge (mergesort (sublist ls 0 middle)) 
             (mergesort (sublist ls middle (length ls)))))))
             
(check-equal? (mergesort (list 4 2 3 1 5 )) (list 1 2 3 4 5))