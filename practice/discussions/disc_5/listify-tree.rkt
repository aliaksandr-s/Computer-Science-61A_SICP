#lang racket/base

(require rackunit)
(require racket/trace)
(require "./trees.rkt")

(define (listify-tree tree)
  (cons (datum tree) (listify-forest (children tree))))

(define (listify-forest forest)
  (if (null? forest)
      '()
      (append (listify-tree (car forest)) (listify-forest (cdr forest)))))

(define t1
  (make-tree 1
	           (list (make-tree 2 (leaves 3 4))
		               (make-tree 5 (leaves 6 7 8)) )))

(check-equal? (listify-tree t1) '(1 2 3 4 5 6 7 8))