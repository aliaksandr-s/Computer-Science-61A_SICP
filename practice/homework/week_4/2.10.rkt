#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)
(require "./2.7.rkt")

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
  (make-interval (min p1 p2 p3 p4)
                 (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (and (< (lower-bound y) 0)
           (> (upper-bound y) 0)) 
      (error "second interval should not cross zero")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                  (/ 1.0 (lower-bound y))))))

(check-equal? (div-interval (make-interval 2 2)
                            (make-interval 2 2))
              (make-interval 1.0 1.0))
(check-exn
  exn:fail?
  (lambda () (div-interval (make-interval 2 2)
                            (make-interval -2 2))))
