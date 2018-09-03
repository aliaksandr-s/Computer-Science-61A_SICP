#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (deep-reverse l)
  (cond [(empty? l) '()]
        [(not (list? l)) l]
        [else (append (deep-reverse (cdr l)) 
                      (list (deep-reverse (car l))))]))

(check-equal? (deep-reverse (list (list 1 2) (list 3 4)))
              '((4 3) (2 1)))

(check-equal? (deep-reverse '((1 2 3) ((4 5) ((6 7) (8 9))) (10 11))) 
              '((11 10) (((9 8) (7 6)) (5 4)) (3 2 1)))