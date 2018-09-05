#lang racket/base

(require rackunit)
(require racket/trace)
(require "./trees.rkt")
(require "./max-of-tree.rkt")

(define (max-heap? tree)
  (and (= (datum tree) (max-of-tree tree)) 
       (max-heaps? (children tree))))

(define (max-heaps? forest)
  (cond [(null? forest) #t]
        [else (and (max-heap? (car forest))
                   (max-heaps? (cdr forest)))]))

(define t1
  (make-tree 10
	           (list (make-tree 9 (leaves 3 4))
		               (make-tree 8 (leaves 1 2 3)) )))

(define t2
  (make-tree 7 
	           (list (make-tree 2 (leaves 3 4))
		               (make-tree 5 (leaves 6 5)) )))

(check-equal? (max-heap? t1) #t)
(check-equal? (max-heap? t2) #f)