#lang racket/base

(require rackunit)
(require racket/trace)
(require "./bst.rkt")

(define (height-of bst)
  (if (null? bst) 
      0
      (+ 1 (max (height-of (left-branch bst)) 
                (height-of (right-branch bst))))))

(define tree1
  (make-tree 7
	  (make-tree 3
	    (make-tree 1 '() '())
	    (make-tree 5 '() '()))
	  (make-tree 9 '() (make-tree 11 '() '()))))

(check-equal? (height-of tree1) 3)