#lang racket/base

(require rackunit)
(require racket/trace)
(require "./bst.rkt")

(define (sum-of bst)
  (if (null? bst)
      0
      (+ (entry bst) 
         (sum-of (left-branch bst))
         (sum-of (right-branch bst)))))

(define tree1
  (make-tree 7
	  (make-tree 3
	    (make-tree 1 '() '())
	    (make-tree 5 '() '()))
	  (make-tree 9 '() (make-tree 11 '() '()))))

(check-equal? (sum-of tree1) 36)