#lang racket

(require rackunit)
(require racket/trace)

(define (equal? ls1 ls2)
  (cond [(and (null? ls1) (null? ls2))
          #t]
        [(and (not (list? ls1)) (not (list? ls2)))
          (eq? ls1 ls2)]
        [(or (and (empty? ls1) (not (empty? ls2)))
             (and (empty? ls2) (not (empty? ls1))))
          #f]
        [else (and (list? ls1) 
              (list? ls2)
              (equal? (car ls1) (car ls2))
              (equal? (cdr ls1) (cdr ls2)))]))

(check-equal? (equal? '(1 2 3 (4 5) 6) '(1 2 3 (4 5) 6)) #t)
(check-equal? (equal? '(1 2 3 (4 5) 6) '(1 2 3 (4 5 7) 6)) #f)