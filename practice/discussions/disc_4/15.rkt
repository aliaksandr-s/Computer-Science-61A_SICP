#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (square x) (* x x))
(define (double x) (* 2 x))
(define (plus-one x) (+ x 1))

(define (apply-procs procs args)
  (define (apply-proc el)
    (define (iter el procs)
      (if (null? procs) 
          el 
          (iter ((car procs) el) (cdr procs))))
    (iter el procs))
  (map apply-proc args))

(define (apply-procs2 procs args)
  (if (null? procs)
      args
      (apply-procs2 (cdr procs) (map (car procs) args))))

(check-equal? (apply-procs (list square double plus-one) '(1 2 3 4)) '(3 9 19 33))
(check-equal? (apply-procs2 (list square double plus-one) '(1 2 3 4)) '(3 9 19 33))