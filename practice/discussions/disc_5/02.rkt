#lang racket/base

(require rackunit)
(require racket/trace)
(require "./trees.rkt")

(define (max-of-tree tree)
  (if (null? (children tree))
      (datum tree)
      (max (datum tree) (max-of-forest (children tree)))))

(define (max-of-forest forest)
  (if (null? (cdr forest))
      (max-of-tree (car forest))
      (max (max-of-tree (car forest)) (max-of-forest (cdr forest)))))

(trace max-of-tree)
(trace max-of-forest)

(define t1
  (make-tree 1
	           (list (make-tree 2 (leaves 3 4))
		               (make-tree 5 (leaves 6 7 8)) )))

(check-equal? (max-of-tree t1) 8)