#lang racket/base

(require rackunit)
(require racket/trace)
(require "./bst.rkt")

(define (max-of bst)
  (if (null? (right-branch bst))
      (entry bst)
      (max-of (right-branch bst))))

(define tree1
  (make-tree 7
	  (make-tree 3
	    (make-tree 1 '() '())
	    (make-tree 5 '() '()))
	  (make-tree 9 '() (make-tree 11 '() '()))))

(check-equal? (max-of tree1) 11)