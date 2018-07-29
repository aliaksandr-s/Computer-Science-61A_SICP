#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (count-ways current-pos target-pos size)
  (define cur-x (first current-pos))
  (define cur-y (first (bf current-pos)))
  (define targ-x (first target-pos))
  (define targ-y (first (bf target-pos)))
  (define size-x (first target-pos))
  (define size-y (first (bf target-pos)))

  (cond [(and (= cur-x targ-x) (= cur-y targ-y)) 1]
        [(or (> cur-x size-x) (> cur-y size-y)) 0]
        [else (+ (count-ways (se (+ cur-x 1) cur-y) target-pos size) 
                 (count-ways (se cur-x (+ cur-y 1)) target-pos size))]))

(check-equal? (count-ways `(1 1) `(2 3) `(4 4)) 3)
(check-equal? (count-ways `(1 1) `(3 2) `(4 4)) 3)
(check-equal? (count-ways `(1 1) `(2 2) `(4 4)) 2)



(define (count-ways-new x y)
  (cond [(or (= x 0) (= y 0)) 1]
        [else (+ (count-ways-new x (- y 1))
                  (count-ways-new (- x 1) y))]))

(check-equal? (count-ways-new 2 2) 6)