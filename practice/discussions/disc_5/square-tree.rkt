#lang racket/base

(require rackunit)
(require racket/trace)
(require "./trees.rkt")

(define (square x) (* x x))

(define (square-tree tree)
  (make-tree (square (datum tree))
             (square-forest (children tree))))
 
(define (square-forest forest)
  (if (null? forest)
      '()
      (cons (square-tree (car forest))
            (square-forest (cdr forest)))))

(define t1
  (make-tree 1
	           (list (make-tree 2 (leaves 3 4))
		               (make-tree 5 (leaves 6 7 8)) )))

(define sq-t1
  (make-tree 1
	           (list (make-tree 4 (leaves 9 16))
		               (make-tree 25 (leaves 36 49 64)) )))

(check-equal? (square-tree t1) sq-t1)
